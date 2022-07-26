library(dplyr)
library(tidyverse)
library(tidyr)
library(tidytext)
library(tibble)
library(knitr)

# total tweets
total_tweets <- sum(nrow(raw_data[index,]))

# regional tweets
regional_tweets <- raw_data[index,] %>%
  mutate(Region = region) %>%
  group_by(Region) %>%
  summarise(Tweets = sum(tweets) / 10^3) %>%
  rename("Tweets (000s)" = Tweets)

# Combined table
combined_table <- regional_tweets %>%
  group_by(Region) %>%
  mutate("Tweets (%)" = (`Tweets (000s)` / total_tweets) * 10^5) %>%
  ungroup()

# final regional summary table
final_regional_table <- combined_table %>%
  add_row("Region" = "Total",
          "Tweets (000s)" = sum(combined_table$`Tweets (000s)`),
          "Tweets (%)" = 100)

kable(final_regional_table, align = 'c')



# Anglo tweets
anglo_tweets <- combined_raw_data %>%
  filter(region == "Anglo") %>%
  mutate(Country = country) %>%
  group_by(Country) %>%
  summarise(Tweets = sum(tweets) / 10^3) %>%
  rename("Tweets (000s)" = Tweets)

# Combined Anglo table
combined_anglo_table <- anglo_tweets %>%
  group_by(Country) %>%
  mutate("Tweets (%)" = (`Tweets (000s)` / total_tweets) * 10^5) %>%
  ungroup()

# final regional summary table
final_anglo_table <- combined_anglo_table %>%
  add_row("Country" = "Total",
          "Tweets (000s)" = sum(combined_anglo_table$`Tweets (000s)`),
          "Tweets (%)" = 100)

kable(final_anglo_table, align = 'c')



# Sinic tweets
sinic_tweets <- combined_raw_data %>%
  filter(region == "Sinic") %>%
  mutate(Country = country) %>%
  group_by(Country) %>%
  summarise(Tweets = sum(tweets) / 10^3) %>%
  rename("Tweets (000s)" = Tweets)

# Combined Anglo table
combined_sinic_table <- sinic_tweets %>%
  group_by(Country) %>%
  mutate("Tweets (%)" = (`Tweets (000s)` / total_tweets) * 10^5) %>%
  ungroup()

# final regional summary table
final_sinic_table <- combined_sinic_table %>%
  add_row("Country" = "Total",
          "Tweets (000s)" = sum(combined_sinic_table$`Tweets (000s)`),
          "Tweets (%)" = 100)

kable(final_sinic_table, align = 'c')

