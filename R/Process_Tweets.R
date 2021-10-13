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
library(jsonlite)

# read in spreadsheet data without including duplicate 
# tweets  from the previous week's search results.  
read_data <- function(file_name) {
  file <- read_csv(here("data", file_name))
  return(file[,c(1,2,4,5,6,7,9)])
}

# performs the read_data function for all of the data frames
# and joins them into a single tibble data frame. 
read_all_data <- function(dataframes) {
  data <- list()
  for(i in 1:length(dataframes)) {
    data[[i]] <- read_data(file_name = paste0(dataframes[i], 
                                              ".csv"))
  }
  return(as_tibble(rbind_pages(data)))
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
    select(region, sentiment, percent, week) %>%
    group_by(region, sentiment, week) %>%
    summarise(percent = sum(percent))
}

# calculates the sentiment for each search term
# as a percentage of total words. 
calculate_search_term_percentages <- function(words) {
  final_value <- words %>%
    group_by(region, search, week) %>%
    mutate(total_words = sum(words),
           percent = (words / total_words)*100) %>%
    select(region, search, sentiment, percent, week) %>%
    group_by(region, search, sentiment, week) %>%
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

# a list of different data frame names.  
dataframes <- c("11-05-2021", "18-05-2021", "25-05-2021",
                "01-06-2021", "08-06-2021", "15-06-2021", 
                "22-06-2021", "29-06-2021", "06-07-2021", 
                "13-07-2021", "20-07-2021", "27-07-2021", 
                "03-08-2021", "10-08-2021", "17-08-2021", 
                "24-08-2021", "31-08-2021", "07-09-2021", 
                "14-09-2021", "21-09-2021", "28-09-2021", 
                "05-10-2021", "12-10-2021")

# a combined list of raw data. 
raw_data <- read_all_data(dataframes)

# creates an index of non-duplicated tweets.
index <- which(!duplicated(raw_data[,1]))

# counts the frequency of different NRC sentiments.  
words <- join_words_with_sentiment(raw_data[index,]) %>%
  spread(sentiment, words) %>%
  rename("Anticipation" = "anticipation", 
         "Joy" = "joy", 
         "Trust" = "trust",
         "Anger" = "anger", 
         "Disgust" = "disgust", 
         "Fear" = "fear") %>%
  gather(sentiment, words, -c(1:4)) %>%
  mutate(words = replace_na(words, replace = 0)) 

# Calculates each sentiment as a percentage of 
# total words based on region. 
regional_percentages <- calculate_regional_percentages(words)

# Calculates each sentiment as a percentage of 
# total words based on week.  
week_percentages <- calculate_week_percentages(words)

# calculates each sentiment as a percentage of 
# total words based on search term.  
search_term_percentages <- calculate_search_term_percentages(words) 

# calculates each sentiment as a percentage of 
# total words based on country.  
country_percentages <- calculate_country_percentages(words) 
