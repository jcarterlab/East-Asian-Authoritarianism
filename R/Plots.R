library(dplyr)
library(tidyverse)
library(readxl)
library(ggplot2)
library(ggthemes)
library(here)
library(ggrepel)
library(knitr)
library(kableExtra)

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

# Region
regional_percentages %>%
  spread(
    sentiment, percent
  ) %>%
  mutate(
    net = positive - negative
  ) %>%
  gather(
    sentiment, percent, -1
  ) %>%
  filter(
    sentiment == "net"
  ) %>%
  ggplot(
    aes(x = region, y = percent, fill = region)
  ) +
  geom_bar(
    stat = "identity", position = "dodge"
  ) +
  ggtitle(
    "Region"
  ) +
  ylab(
    "Net Sentiment"
  ) +
  xlab("") +
  scale_fill_manual(
    values = c("#0072B2", "#D55E00")
  ) +
  my_theme

# week
week_percentages %>%
  spread(
    sentiment, percent
  ) %>%
  mutate(
    net = positive - negative
  ) %>%
  gather(
    sentiment, percent, -c(1:2)
  ) %>%
  filter(
    sentiment == "net"
  ) %>%
  ggplot(
    aes(x = week, y = percent, fill = region)
  ) +
  geom_bar(
    stat = "identity", position = "dodge"
  ) +
  ggtitle(
    "Week"
  ) +
  ylab(
    "Net Sentiment"
  ) +
  xlab("") +
  scale_fill_manual(
    values = c("#0072B2", "#D55E00")
  ) +
  my_theme

# search terms
search_term_percentages %>%
  spread(
    sentiment, percent
  ) %>%
  mutate(
    net = positive - negative
  ) %>%
  gather(
    sentiment, percent, -c(1:2)
  ) %>%
  filter(
    sentiment == "net"
  ) %>%
  ggplot(
    aes(x = search, y = percent, fill = region)
  ) +
  geom_bar(
    stat = "identity", position = "dodge"
  ) +
  ggtitle(
    "Search Term"
  ) +
  ylab(
    "Net Sentiment"
  ) +
  xlab("") +
  scale_fill_manual(
    values = c("#0072B2", "#D55E00")
  ) +
  my_theme +
  scale_x_discrete(
    guide = guide_axis(n.dodge=2)
  )

# selected countries 
country_percentages %>%
  spread(
    sentiment, percent
  ) %>%
  mutate(
    net = positive - negative,
    country = factor(country, 
                     levels=c("Australia", "Canada", "New Zealand", 
                              "South Africa", "UK", "US", 
                              "China",  "Hong Kong", "Singapore", 
                              "South Korea", "Taiwan", "Vietnam"))
  ) %>%
  gather(
    sentiment, percent, -c(1:3)
  ) %>%
  filter(
    sentiment == "net"
  ) %>%
  ggplot(
    aes(x = country, y = percent, fill = region)
  ) +
  geom_bar(
    stat = "identity", position = "dodge"
  ) +
  ggtitle(
    "Country"
  ) +
  ylab(
    "Net Sentiment"
  ) +
  xlab("") +
  scale_fill_manual(
    values = c("#0072B2", "#D55E00")
  ) +
  my_theme +
  scale_x_discrete(
    guide = guide_axis(n.dodge=2)
  )



