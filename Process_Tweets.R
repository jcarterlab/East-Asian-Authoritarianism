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

### functions ###
# read in spreadsheets without including the same tweets twice
read_data <- function(file_name, previous_file=NULL) {
  file <- read_twitter_csv(here("data", file_name)) %>%
    mutate(status_id = as.numeric(status_id))
  if(!is.null(previous_file)) file <- file %>%
      filter(status_id > max(previous_file$status_id))
  return(file)
}

### 1. the data ###
# 1.1 read in data sets as csv files
april_10_21 <- read_data("10-04-2021.csv")
april_17_21 <- read_data("17-04-2021.csv", april_10_21)

# 1.2 bind the data sets together as one object
combined_raw_data <- april_10_21 %>% 
  rbind(april_17_21) 

### 2. functions ###
# 2.1 breaks the text down and inner joins with the nrc sentiment library
join_words_with_sentiment <- function(raw_tweets) {
  nrc_sentiment <- get_sentiments("nrc") %>% 
    select(word, sentiment)
  
  words <- raw_tweets %>%
    unnest_tokens(word, text) %>%
    left_join(nrc_sentiment, by = "word") %>%
    mutate(sentiment = replace_na(sentiment, replace = "none")) %>%
    filter(!word %in% stop_words$word) %>%
    select(word, sentiment, country, region, 
           date_collected, tweets, search) %>%
    group_by(sentiment, country, region, date_collected, tweets, search) %>%
    count(sentiment) %>%
    rename(words = "n")
    return(words)
}

# 2.3 calculates the sentiments for each region as a %

calculate_final_value <- function(words) {
  final_value <- words %>%
    group_by(search, region, date_collected) %>%
    mutate(total_words = sum(words)) %>%
    group_by(search, region, sentiment, date_collected, total_words) %>%
    mutate(percent = words / total_words) %>%
    summarize(value = sum(percent) * 100)
}

# 2.4 break the data down into individual words and process it 
words <- join_words_with_sentiment(combined_raw_data)

tweets <- calculate_final_value(words) %>%
  spread(sentiment, value) %>%
  rename("Anticipation" = "anticipation",
         "Joy" = "joy",
         "Trust" = "trust",
         "Anger" = "anger",
         "Disgust" = "disgust",
         "Fear" = "fear") %>%
  gather(sentiment, value, -c(1:4)) 

# 2.5 processes the averages for anti-authority words
anti_authority_data <- tweets %>%
  filter(search %in% c("Protest", "Rebel", 
                       "Revolt", "Riot")) %>%
  group_by(region, date_collected, sentiment) %>%
  summarise(avg = sum(value) / length(value))

