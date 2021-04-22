library(dplyr)
library(tidyverse)
library(tidyr)
library(tidytext)

### 1. stats ###
# 1.1 macro stats
total_words <- sum(words$words)

macro_words_table <- words %>%
  mutate(Region = region) %>%
  group_by(Region) %>%
  summarise(Words = sum(words) / 10^3,
            "Words (%)" = Words / (total_words) * 10^5) %>%
  rename("Words (000s)" = Words)

total_tweets <- sum(combined_raw_data$tweets)

combined_raw_data %>%
  mutate(Region = region) %>%
  group_by(Region) %>%
  summarise(Tweets = sum(tweets) / 10^3,
            "Tweets (%)" = Tweets / (total_tweets) * 10^5) %>%
  rename("Tweets (000s)" = Tweets) %>%
  left_join(macro_words_table) %>%
  tibble()

# 1.2 micro stats
micro_words_table <- words %>%
  mutate(Region = region,
         Country = country) %>%
  group_by(Region, Country) %>%
  summarise(Words = sum(words) / 10^3,
            "Words (%)" = Words / (total_words) * 10^5) %>%
  rename("Words (000s)" = Words)

combined_raw_data %>%
  mutate(Region = region,
         Country = country) %>%
  group_by(Region, Country) %>%
  summarise(Tweets = sum(tweets) / 10^3,
            "Tweets (%)" = Tweets / (total_tweets) * 10^5) %>%
  rename("Tweets (000s)" = Tweets) %>%
  left_join(micro_words_table) %>%
  tibble()

