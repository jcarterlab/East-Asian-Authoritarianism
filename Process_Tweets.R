library(dplyr)
library(tidyverse)
library(ggplot2)
library(ggthemes)
library(tidyr)
library(tidytext)
library(rvest)
library(stringr)
library(here)
library(rtweet)

### 1. the data ###
# 1.1 read in data sets as csv files 
april_06_21 <- read_csv(here("data", "06-04-2021.csv"))

# 1.2 bind the data sets together as one object
combined_raw_data <- april_06_21


### 2. functions ###
# 2.1 breaks the text down and inner joins with the nrc sentiment library
join_words_with_sentiment <- function(table) {
  nrc_sentiment <- get_sentiments("nrc") %>% 
    select(word, sentiment)
  table <- table %>%
    unnest_tokens(word, text) %>%
    inner_join(nrc_sentiment, by = "word") %>%
    mutate(sentiment = replace_na(sentiment, replace = "none")) %>%
    filter(!word %in% stop_words$word) %>%
    select(word, sentiment, country, region, 
           date_collected, tweets, search) %>%
    return()
}

# 2.2 counts the number of times each sentiment occurs in each region
calculate_word_count <- function(country_sentiment) {
  word_count <- country_sentiment %>%
    group_by(sentiment, country, region, date_collected, tweets, search) %>%
    count(sentiment)
  return(word_count)
}

# 2.3 calculates the sentiments for each region's search terms as a %
process_final_data <- function(tweets) {
  sentiment <- join_words_with_sentiment(tweets)
  final_value <- calculate_word_count(sentiment) %>%
    rename(words = "n") %>%
    group_by(search, region, date_collected) %>%
    mutate(total_words = sum(words),
           total_tweets = sum(tweets)) %>%
    group_by(search, region, sentiment, date_collected, total_tweets, total_words) %>%
    mutate(percent = words / total_words) %>%
    summarize(value = sum(percent) * 100)
  return(final_value)
}

# 2.4 binds all of the results together
processed_data <- process_final_data(combined_raw_data)


### 3. plot theme
# 3.1 creates my plot theme
my_theme <- theme_economist_white(gray_bg = FALSE) +
  theme(plot.title = element_text(hjust = 0.5, 
                                  vjust = 7.5, 
                                  size = 12, 
                                  color = "#474747"),
        plot.margin = unit(c(1.5, 1, 1.5, 1), "cm"),
        axis.text = element_text(size = 9, 
                                 color = "gray30"),
        axis.text.x=element_text(vjust = -2.5),
        axis.title.x = element_text(size = 9, 
                                    color = "gray30", 
                                    vjust = -10),
        axis.title.y = element_text(size = 9, 
                                    color = "gray30", 
                                    vjust = 10),
        legend.direction = "vertical", 
        legend.position = "right",
        legend.title = element_blank(),
        legend.text = element_text(size = 12, 
                                   color = "gray20"),
        legend.margin=margin(1, -15, 1, 0),
        legend.spacing.x = unit(0.25, "cm"),
        legend.key.size = unit(1, "cm"), 
        legend.key.height = unit(0.75, "cm"),
        strip.text = element_text(hjust = 0.5, 
                                  vjust = 1, 
                                  size = 10, 
                                  color = "#474747"),
        panel.spacing = unit(2, "lines"))


### 4. plots net sentiment
# 4.1 plots net sentiment for uyghurs
processed_data %>%
  spread(sentiment, value) %>%
  mutate(net = positive - negative) %>%
  gather(sentiment, value, -c(1:5)) %>%
  filter(sentiment == "net",
         search == "Uyghurs") %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~search) +
  ggtitle("Net Sentiment") +
  ylab("%") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# 4.2 plots net sentiment for freedom
processed_data %>%
  spread(sentiment, value) %>%
  mutate(net = positive - negative) %>%
  gather(sentiment, value, -c(1:5)) %>%
  filter(sentiment == "net",
         search == "Freedom") %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~search) +
  ggtitle("Net Sentiment") +
  ylab("%") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# 4.3 plots net sentiment for chaos
processed_data %>%
  spread(sentiment, value) %>%
  mutate(net = positive - negative) %>%
  gather(sentiment, value, -c(1:5)) %>%
  filter(sentiment == "net",
         search == "Chaos") %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~search) +
  ggtitle("Net Sentiment") +
  ylab("%") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# 4.4 plots net sentiment for anti-authority word basket
processed_data %>%
  spread(sentiment, value) %>%
  mutate(net = positive - negative) %>%
  gather(sentiment, value, -c(1:5)) %>%
  filter(sentiment == "net",
         search %in% c("Dissent", "Protest", 
                       "Rebel","Revolt")) %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~search) +
  ggtitle("Net Sentiment") +
  ylab("%") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())


### 5. plots emotions

# 5.1 plots trust for anti-authority words
processed_data %>%
  filter(sentiment == "trust",
         search %in% c("Dissent", "Protest", 
                       "Rebel","Revolt")) %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~search) +
  ggtitle("Trust") +
  ylab("Words (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# 5.2 plots anticipation for anti-authority words
processed_data %>%
  filter(sentiment == "anticipation",
         search %in% c("Dissent", "Protest", 
                       "Rebel","Revolt")) %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~search) +
  ggtitle("Anticipation") +
  ylab("Words (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# 5.3 plots joy for anti-authority words
processed_data %>%
  filter(sentiment == "joy",
         search %in% c("Dissent", "Protest", 
                       "Rebel","Revolt")) %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~search) +
  ggtitle("Joy") +
  ylab("Words (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# 5.4 plots anger for anti-authority words
processed_data %>%
  filter(sentiment == "anger",
         search %in% c("Dissent", "Protest", 
                       "Rebel","Revolt")) %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~search) +
  ggtitle("Anger") +
  ylab("Words (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# 5.5 plots disgust for anti-authority words
processed_data %>%
  filter(sentiment == "disgust",
         search %in% c("Dissent", "Protest", 
                       "Rebel","Revolt")) %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~search) +
  ggtitle("Disgust") +
  ylab("Words (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# 5.6 plots fear for anti-authority words
processed_data %>%
  filter(sentiment == "fear",
         search %in% c("Dissent", "Protest", 
                       "Rebel","Revolt")) %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~search) +
  ggtitle("Fear") +
  ylab("Words (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())
