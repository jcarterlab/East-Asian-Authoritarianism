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

# read in spreadsheet data without including duplicate 
# tweets  from the previous week's search results.  
read_data <- function(file_name, previous_file=NULL) {
  file <- read_twitter_csv(here("data", file_name)) %>%
    mutate(status_id = as.numeric(status_id))
  if(!is.null(previous_file)) file <- file %>%
      filter(status_id > max(previous_file$status_id))
  return(file)
}

# breaks the text down into single words, 
# inner joins them with the NRC library 
# and counts the frequency of each sentiment. 
join_words_with_sentiment <- function(raw_tweets) {
  nrc_sentiment <- get_sentiments("nrc") %>% select(word, sentiment)
  words <- raw_tweets %>%
    unnest_tokens(word, text) %>%
    left_join(nrc_sentiment, by = "word") %>%
    mutate(sentiment = replace_na(sentiment, replace = "none")) %>%
    filter(!word %in% stop_words$word) %>%
    group_by(search, region, country, sentiment, week) %>%
    count(sentiment) %>%
    rename(words = "n")
    return(words)
}

# calculates the sentiment for each region
# as a percentage of total words. 
calculate_regional_percentages <- function(words) {
  final_value <- words %>%
    group_by(region) %>%
    mutate(total_words = sum(words),
           percent = (words / total_words)*100) %>%
    select(region, sentiment, percent) %>%
    group_by(region, sentiment) %>%
    summarise(percent = sum(percent))
}

# calculates the sentiment for each week
# as a percentage of total words. 
calculate_week_percentages <- function(words) {
  final_value <- words %>%
    group_by(region, week) %>%
    mutate(total_words = sum(words),
           percent = (words / total_words)*100) %>%
    select(region, week, sentiment, percent) %>%
    group_by(region, week, sentiment) %>%
    summarise(percent = sum(percent))
}

# calculates the sentiment for each country
# as a percentage of total words. 
calculate_country_percentages <- function(words) {
  final_value <- words %>%
    group_by(country, region) %>%
    mutate(total_words = sum(words),
           percent = (words / total_words)*100) %>%
    select(region, country, sentiment, percent) %>%
    group_by(region, country, sentiment) %>%
    summarise(percent = sum(percent))
}

# calculates the sentiment for each search term
# as a percentage of total words. 
calculate_search_term_percentages <- function(words) {
  final_value <- words %>%
    group_by(region, search) %>%
    mutate(total_words = sum(words),
           percent = (words / total_words)*100) %>%
    select(region, search, sentiment, percent) %>%
    group_by(region, search, sentiment) %>%
    summarise(percent = sum(percent))
}

# reads in the data from csv files. 
week_11_05_2021 <- read_data(file_name="11-05-2021.csv")
week_18_05_2021 <- read_data(file_name="18-05-2021.csv", 
                             previous_file=week_11_05_2021)
week_25_05_2021 <- read_data(file_name = "25-05-2021.csv",
                             previous_file = week_18_05_2021)

# binds the data together as a single object. 
combined_raw_data <- week_11_05_2021 %>%
  rbind(week_18_05_2021) %>%
  rbind(week_25_05_2021)

# counts the frequency of different NRC sentiments.  
words <- join_words_with_sentiment(combined_raw_data) %>%
  spread(sentiment, words) %>%
  rename("Anticipation" = "anticipation", "Joy" = "joy", "Trust" = "trust",
         "Anger" = "anger", "Disgust" = "disgust", "Fear" = "fear") %>%
  gather(sentiment, words, -c(1:4)) %>%
  mutate(words = replace_na(words, replace = 0)) 

# Calculates each sentiment as a percentage of 
# total words based on region. 
regional_percentages <- calculate_regional_percentages(words)

# Calculates each sentiment as a percentage of 
# total words based on week 
week_percentages <- calculate_week_percentages(words)

# calculates each sentiment as a percentage of 
# total words based on search term.  
search_term_percentages <- calculate_search_term_percentages(words) 

# calculates each sentiment as a percentage of 
# total words based on country.  
country_percentages <- calculate_country_percentages(words) 


