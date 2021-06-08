East Asian Authoritarianism?
================
Jack Carter
5/11/2021

## **Summary**

This repository analyzes anti-authority sentiment between Anglophone and
Sinic countries. It finds that Sinic country Twitter users demonstrate
significantly less positive sentiment in tweets containing a collection
of nine anti-authority words. This may be due to the differing influence
of Confucian verses European enlightenment values in defining attitudes
towards individual liberty.

Yet given how a large portion of Sinic country Twitter users heavily
criticize the recent military coup in neighboring Myanmar, these
findings could also represent a greater use of hyperbolic language
between increasingly split pro-hierarchy and pro-democracy groups in the
Sino world.

The rest of the report is organized into the following sections:

1)  Authority & Democracy
2)  Sentiment Analysis

 

## **1: Authority & Democracy**

1.1: Power distance scores in Hofstede’s seminal cultural dimension’s
study. Power distance is the extent to which people accept unequal power
and authority in society *(Hofstede, 1980)*.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

1.2: Aspects of democracy according to The Economist Intelligence Unit’s
Democracy Index *(EIU, 2020)*.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

 

## **2: Sentiment Analysis**

Tweets are collected within 50 miles of the Anglophone (the US, the UK,
Canada, Australia, New Zealand and South Africa) and Sinic (China,
Vietnam, Taiwan, South Korea, Hong Kong and Singapore) country capitals
from the 11th of May 2021 to present. A sentiment analysis is then
conducted using the NRC sentiment library.

The anti-authority words include 1) defy, 2) disobey, 3) dissent, 4)
oppose, 5) protest, 6) rebel, 7) resist, 8) revolt and 9) riot.

Figures 2.1 to 2.4 show net sentiment (positive minus negative words),
while figures 2.5 to 2.6 show the total sentiment for specific emotions.

<br>

### Summary Statistics:

| Region | Tweets (000s) | Tweets (%) |
| :----: | :-----------: | :--------: |
| Anglo  |     89.2      |    33.5    |
| Sinic  |     177.4     |    66.5    |
| Total  |     266.6     |   100.0    |

 

### Net Sentiment:

2.1: The overall net sentiment. Net sentiment is calculated here as
positive minus negative words expressed as a percentage of the overall
total.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

2.2: The net sentiment for each week during the data collection process.
Net sentiment is calculated here as positive minus negative words
expressed as a percentage of the weekly total.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

2.3: The net sentiment for each country. Net sentiment is calculated
here as positive minus negative words expressed as a percentage of the
country total.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

2.4: The net sentiment for each search term. Net sentiment is calculated
here as positive minus negative words expressed as a percentage of
search term total.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

### Specific Emotions:

2.4: Total sentiment for selected positive emotions. This figure is
calculated as the number of words matching each emotion expressed as a
percentage of total words.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

2.5: Total sentiment for selected negative emotions. This figure is
calculated as the number of words matching each emotion expressed as a
percentage of total words.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

 

## **Sources**

  - EIU (2020) <https://www.eiu.com/n/campaigns/democracy-index-2020/>

  - Hofstede (1980)
    <https://www.tandfonline.com/doi/abs/10.1080/00208825.1980.11656300?journalCode=mimo20>

  - Mohammad (2021)
    <https://saifmohammad.com/WebPages/NRC-Emotion-Lexicon.htm>

  - Twitter (2021) <https://developer.twitter.com/en/apply-for-access>
