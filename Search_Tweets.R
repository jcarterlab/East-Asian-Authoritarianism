library(dplyr)
library(tidyverse)
library(ggplot2)
library(ggthemes)
library(tidyr)
library(tidytext)
library(stringr)
library(rtweet)

### 1. definitions ###
# 1.1 defines the date collected which is later to be used as a column
date_collected <- 20210406

# 1.2 defines the regions which are later to be used as a column
region_1 <- "Sinic"
region_2 <- "Anglophone"

# 1.3 defines the search terms
search_term_1 <- "uyghur OR uyghurs OR uighur OR uighurs"
search_term_2 <- "freedom OR freedoms"
search_term_3 <- "chaos OR chaotic"
search_term_4 <- "dissent OR dissenter OR dissident"
search_term_5 <- "protest OR protesters"
search_term_6 <- "rebel OR rebellion"
search_term_7 <- "revolt OR revolution"

# 1.4 defines the labels which is later to be used as a column
label_1 <- "Uyghurs"
label_2 <- "Freedom"
label_3 <- "Chaos"
label_4 <- "Dissent"
label_5 <- "Protest"
label_6 <- "Rebel"
label_7 <- "Revolt"


### 2. functions ###
# 2.1 searches for tweets with a given search term in a given location
get_tweets <- function(search_term, coordinates) {
  search_tweets(
    q = search_term,
    n = 50000,
    include_rts = FALSE,
    retryonratelimit = TRUE,
    lang = "en",
    geocode = coordinates
  )
}

# 2.2 cleans links from text and selects the desired columns
process_raw_tweet_data <- function(country) {
  pattern <- "https://t.co/[A-Za-z\\d]+|&amp;"
  result <- country %>%
    select(status_id, text, created_at) %>%
    mutate(text = str_replace_all(text, pattern, ""))
  return(result)
}

# 2.3 performs the previous two functions and adds five extra columns
process_data <- function(search_term, coordinates, country_name, region, date_collected, label) {
  country <- get_tweets(search_term, coordinates)
  clean <- process_raw_tweet_data(country)
  result <- clean %>%
    mutate(country = country_name,
           region = region,
           date_collected = date_collected,
           tweets = nrow(clean),
           search = label)
  return(result)
}

# 2.4 searches for each search term and binds the results together
process_country <- function(coordinates, country, region, date_collected) {
  search_1 <- process_data(search_term_1, coordinates, country,
                           region, date_collected, label_1)
  search_2 <- process_data(search_term_2, coordinates, country,
                           region, date_collected, label_2)
  search_3 <- process_data(search_term_3, coordinates, country,
                           region, date_collected, label_3)
  search_4 <- process_data(search_term_4, coordinates, country,
                           region, date_collected, label_4)
  search_5 <- process_data(search_term_5, coordinates, country,
                           region, date_collected, label_5)
  search_6 <- process_data(search_term_6, coordinates, country,
                           region, date_collected, label_6)
  search_7 <- process_data(search_term_7, coordinates, country,
                           region, date_collected, label_7)
  result <- search_1 %>%
    rbind(search_2) %>%
    rbind(search_3) %>%
    rbind(search_4) %>%
    rbind(search_5) %>%
    rbind(search_6) %>%
    rbind(search_7)
  return(result)
} 


### 3. searches ###
# 3.1 searches within 50 miles of Sinic country capitals
china <- process_country("39.9042,116.4074,50mi", "China", 
                         region_1, date_collected)
vietnam <- process_country("21.0278,105.8342,50mi", "Vietnam", 
                           region_1, date_collected)
taiwan <- process_country("25.0330,121.5654,50mi", "Taiwan", 
                          region_1, date_collected)
south_korea <- process_country("37.5665,126.9780,50mi", "South Korea", 
                               region_1, date_collected)
hong_kong <- process_country("22.2800,114.1588,50mi", "Hong Kong", 
                             region_1, date_collected)
singapore <- process_country("1.3521,103.8198,50mi", "Singapore", 
                             region_1, date_collected)

# 3.2 searches within 50 miles of Anglophone country capitals
us <- process_country("38.9072,-77.0369,50mi", "US", 
                      region_2, date_collected)
uk <- process_country("51.5074,-0.1278,50mi", "UK", 
                      region_2, date_collected)
canada <- process_country("45.4215,-75.6972,50mi", "Canada", 
                          region_2, date_collected)
australia <- process_country("-35.4735,149.0124,50mi", "Australia", 
                             region_2, date_collected)
new_zealand <- process_country("-41.2924,174.7787,50mi", "New Zealand", 
                               region_2, date_collected)
south_africa <- process_country("-25.7479,28.2293,50mi", "South Africa", 
                                region_2, date_collected)

# 3.3 binds the results together and drops duplicates
tidy_table <- china %>%
  rbind(vietnam) %>%
  rbind(taiwan) %>%
  rbind(south_korea) %>%
  rbind(hong_kong) %>%
  rbind(singapore) %>%
  rbind(us) %>%
  rbind(uk) %>%
  rbind(canada) %>%
  rbind(australia) %>%
  rbind(new_zealand) %>%
  rbind(south_africa) %>%
  distinct()

# 3.4 saves the results to a csv file named "change_this_name.csv"
write_as_csv(
  tidy_table, file_name = "change_this_name.csv", 
  prepend_ids = TRUE, na = "", 
  fileEncoding = "UTF-8"
)
