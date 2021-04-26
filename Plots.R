library(dplyr)
library(tidyverse)
library(readxl)
library(ggplot2)
library(ggthemes)
library(here)
library(ggrepel)

# my theme
my_theme <- theme_economist_white(gray_bg = FALSE) +
  theme(plot.title = element_text(hjust = 0.5, 
                                  vjust = 12, 
                                  size = 10, 
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


### 1. democracy ####
# 1.1 democracy scores
democracy_scores <- tibble(country = c("China", "Vietnam", "Hong Kong",
                                       "Singapore", "US", "South Korea",
                                       "UK", "Taiwan", "Canada",
                                       "New Zealand", "South Africa", "Australia"),
                           region = c("Sinic", "Sinic", "Sinic",
                                      "Sinic", "Anglophone", "Sinic",
                                      "Anglophone", "Sinic", "Anglophone",
                                      "Anglophone", "Anglophone", "Anglophone"),
                           "Overall" = c(2.27, 2.94, 5.57,
                                         6.03, 7.72, 8.01,
                                         8.54, 8.94, 9.24,
                                         9.25, 7.05, 8.96),
                           "Electoral Process" = c(0, 0, 3.17,
                                                   4.83, 9.17, 9.17,
                                                   10, 10, 9.58,
                                                   10, 7.42, 10),
                           "Functioning Government" = c(4.29, 2.86, 3.64,
                                                        7.86, 6.79, 8.21,
                                                        7.5, 9.64, 8.93,
                                                        8.93, 7.14, 8.57),
                           "Political Participation" = c(2.78, 3.89, 5,
                                                         4.44, 8.89, 7.22,
                                                         8.89, 7.22, 8.89,
                                                         8.89, 8.33, 7.78),
                           "Political Culture" = c(3.13, 5.63, 7.50,
                                                   6.25, 6.25, 7.5,
                                                   7.50, 8.13, 9.38,
                                                   8.75, 5, 8.75),
                           "Civil Liberties" = c(1.18, 2.35, 8.53,
                                                 6.76, 8.53, 7.94,
                                                 8.82, 9.71, 9.41,
                                                 9.71, 7.35, 9.71)) %>%
  gather(type, value, -c(1:2))

# 1.2 overall democracy
democracy_scores %>%
  filter(type == "Overall") %>%
  ggplot(aes(x = country, y = value, col = region)) +
  geom_point(alpha = 0.9) +
  geom_text_repel(aes(label=country), size = 2.25,
                  show.legend = FALSE,
                  max.overlaps = 5) +
  facet_wrap(~region) +
  ggtitle("Overall Democracy") +
  xlab("") +
  ylab("EIU score") +
  ylim(2, 10) +
  scale_color_manual(values = c("#0072B2", "#D55E00")) +
  theme_economist_white(gray_bg = FALSE) +
  my_theme +
  theme(axis.text.x=element_blank())

# 1.3 aspects of democracy
democracy_scores %>%
  filter(!type == "Overall" & !type == "Functioning Government") %>%
  ggplot(aes(x = country, y = value, col = region)) +
  geom_point(alpha = 0.9) +
  geom_text_repel(aes(label=country), size = 2.25,
                  show.legend = FALSE,
                  max.overlaps = 5) +
  facet_wrap(~type) +
  ggtitle("Aspects of Democracy") +
  xlab("") +
  ylab("EIU score") +
  ylim(0, 13) +
  scale_color_manual(values = c("#0072B2", "#D55E00")) +
  theme_economist_white(gray_bg = FALSE) +
  my_theme +
  theme(axis.text.x=element_blank())

# 1.4 power distance scores (the degree to which people accept unequal power)
power_distance_scores <- tibble(country = c("China", "Hong Kong","Singapore", 
                                              "US", "South Korea","UK", 
                                              "Taiwan", "New Zealand", "South Africa", 
                                              "Australia"),
                                region = c("Sinic", "Sinic", "Sinic", 
                                           "Anglophone", "Sinic", "Anglophone", 
                                           "Sinic", "Anglophone", "Anglophone", 
                                           "Anglophone"),
                                power_distance = c(80, 68, 74, 
                                                     40, 60, 35,
                                                     58, 22, 49, 
                                                     36))

# 1.5 power distance
power_distance_scores %>%
  ggplot(aes(x = country, y = power_distance, col = region)) +
  geom_point(alpha = 0.9) +
  geom_text_repel(aes(label=country), size = 2.25,
                  show.legend = FALSE,
                  max.overlaps = 5) +
  ggtitle("Power Distance") +
  xlab("") +
  ylab("Score") +
  scale_color_manual(values = c("#0072B2", "#D55E00")) +
  theme_economist_white(gray_bg = FALSE) +
  my_theme +
  theme(axis.text.x=element_blank())

# 1.6 re-election rate scores
reelection_rate_scores <- tibble(country = c("Taiwan", "Singapore", "Hong Kong", 
                                             "US", "UK", "Canada", 
                                             "Australia", "New Zealand", "South Africa"),
                                 region = c("Sinic", "Sinic", "Sinic",
                                            "Anglophone", "Anglophone", "Anglophone", 
                                            "Anglophone", "Anglophone", "Anglophone"),
                                 rate = c(1, 1, 1, 
                                             0.6, 0.647058824, 0.666666667, 
                                             0.545454545, 0.523809524, 0.666666667)) %>%
  mutate(rate = rate * 100)

# 1.7 re-election rates
reelection_rate_scores %>%
  ggplot(aes(x = country, y = rate, color = region)) +
  geom_point(alpha = 0.9) +
  geom_text_repel(aes(label=country), size = 2.25,
                  show.legend = FALSE,
                  max.overlaps = 5) +
  ggtitle("Re-election Rates") +
  ylab("%") +
  xlab("") +
  ylim(45, 100) +
  scale_color_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())


### 2. Twitter: Sentiment Analysis ####
# 2.1 freedom
# net sentiment
tweets %>%
  spread(sentiment, value) %>%
  mutate(net = positive - negative) %>%
  gather(sentiment, value, -c(1:5)) %>%
  filter(sentiment == "net",
         search == "Freedom") %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("Freedom") +
  ylab("Sentiment (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# positive
tweets %>%
  filter(search == "Freedom",
         sentiment %in% c("Anticipation", "Joy", "Trust")) %>%
  mutate(sentiment = factor(sentiment, levels = c("Anticipation", "Joy", "Trust",
                                                  "Anger", "Disgust","Fear"))) %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~sentiment) +
  ggtitle("Freedom") +
  ylab("Sentiment (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# negative
tweets %>%
  filter(search == "Freedom",
         sentiment %in% c("Anger", "Disgust","Fear")) %>%
  mutate(sentiment = factor(sentiment, levels = c("Anticipation", "Joy", "Trust",
                                                  "Anger", "Disgust","Fear"))) %>%
  ggplot(aes(x = date_collected, y = value, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~sentiment) +
  ggtitle("Freedom") +
  ylab("Sentiment (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# 2.1 anti-authority
# net sentiment
anti_authority_data %>%
  spread(sentiment, avg) %>%
  mutate(net = positive - negative) %>%
  gather(sentiment, avg, -c(1:2)) %>%
  filter(sentiment == "net") %>%
  ggplot(aes(x = date_collected, y = avg, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("Anti-Authority") +
  ylab("Sentiment (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# positive
anti_authority_data %>%
  filter(sentiment %in% c("Anticipation", "Joy", "Trust")) %>%
  mutate(sentiment = factor(sentiment, levels = c("Anticipation", "Joy", "Trust",
                                                  "Anger", "Disgust","Fear"))) %>%
  ggplot(aes(x = date_collected, y = avg, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~sentiment) +
  ggtitle("Anti-Authority") +
  ylab("Sentiment (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())

# negative
anti_authority_data %>%
  filter(sentiment %in% c("Anger", "Disgust","Fear")) %>%
  mutate(sentiment = factor(sentiment, levels = c("Anticipation", "Joy", "Trust",
                                                  "Anger", "Disgust","Fear"))) %>%
  ggplot(aes(x = date_collected, y = avg, fill = region)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~sentiment) +
  ggtitle("Anti-Authority") +
  ylab("Sentiment (%)") +
  xlab("") +
  scale_fill_manual(values = c("#0072B2", "#D55E00")) +
  my_theme +
  theme(axis.text.x=element_blank())
