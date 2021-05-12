library(dplyr)
library(tidyverse)
library(ggplot2)
library(ggthemes)
library(tidyr)
library(tidytext)
library(stringr)
library(rtweet)
library(jsonlite)

# defines the collection date which is used as a column later on.
date_collected <- "11-05-2021"

# defines the region which is used as a column later on.
region <- c("Sinic", "Anglo")

# defines the search term which is used as a column later on.
search_term <- c("defy", "disobey", "dissent", "oppose", "protest",
                 "rebel", "resist", "revolt", "riot")

# defines the label which is used as a column later on. 
label <- c("Defy", "Disobey", "Dissent", "Oppose", "Protest",
           "Rebel", "Resist", "Revolt", "Riot")

# searches for tweets with a given search term in a given 
# location using the rtweet search_tweets function. 
get_tweets <- function(search_term, coordinates) {
  search_tweets(
    q = search_term,
    n = 100000,
    include_rts = FALSE,
    retryonratelimit = TRUE,
    lang = "en",
    geocode = coordinates
  )
}

# cleans links from text and selects the desired 
# columns of status_id, text and created_at. 
process_raw_tweet_data <- function(country) {
  pattern <- "https://t.co/[A-Za-z\\d]+|&amp;"
  result <- country %>%
    select(status_id, text, created_at) %>%
    mutate(text = str_replace_all(text, pattern, ""))
  return(result)
}

# performs previous functions and adds 
# country, region, date and search columns. 
process_data <- function(search_term, coordinates, country_name, region, date_collected, label) {
  country <- get_tweets(search_term, coordinates)
  clean <- if(!is.null(country$status_id)) {
    process_raw_tweet_data(country)
  } 
  result <- if(!is.null(clean$status_id)) {
    clean %>%
      mutate(country = country_name,
             region = region,
             date_collected = date_collected,
             search = label,
             tweets = 1)
  }
  if(!is.null(result$country)) return(result)
}

# collects tweets for each search term and binds the 
# results together into a tibble data frame. 
process_country <- function(country, region, coordinates) {
  searches <- list() 
  for(i in 1:length(search_term)){
    collect <- process_data(search_term[i], coordinates, country,
                            region, date_collected, label[i])
    searches[[i+1]] <- collect
  }
  result <- tibble(rbind_pages(searches))
  return(result)
} 

# searches within 50 miles of Sinic country capitals
# with parameters country name, region and coordinates. 
china <- process_country("China", region[1], "39.9042,116.4074,50mi")
  vietnam <- process_country("Vietnam", region[1], "21.0278,105.8342,50mi")
  taiwan <- process_country("Taiwan", region[1], "25.0330,121.5654,50mi")
  south_korea <- process_country("South Korea", region[1], "37.5665,126.9780,50mi")
  hong_kong <- process_country("Hong Kong", region[1], "22.2800,114.1588,50mi")
  singapore <- process_country("Singapore", region[1], "1.3521,103.8198,50mi")

# searches within 50 miles of Anglophone country capitals
# with parameters country name, region and coordinates. 
us <- process_country("US", region[2], "38.9072,-77.0369,50mi")
  uk <- process_country("UK", region[2], "51.5074,-0.1278,50mi")
  canada <- process_country("Canada", region[2], "45.4215,-75.6972,50mi")
  australia <- process_country("Australia", region[2], "-35.4735,149.0124,50mi")
  new_zealand <- process_country("New Zealand", region[2], "-41.2924,174.7787,50mi")
  south_africa <- process_country("South Africa", region[2], "-25.7479,28.2293,50mi")

# binds the results together and drops duplicate 
# tweets as a single tibble data frame. 
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
  distinct() %>%
  mutate(tweets = 1)

# saves the results to a csv file in the current
# working directory named "change_this_name.csv". 
write_as_csv(
  tidy_table, file_name = "change_this_name.csv", 
  prepend_ids = TRUE, na = "", 
  fileEncoding = "UTF-8"
)


