East Asian Authoritarianism?
================
Jack Carter
5/11/2021

## **Summary**

This repository analyzes anti-authority sentiment between Anglophone and
Sinic countries. It finds that Sinic country Twitter users demonstrate
significantly less positive sentiment in a collection of tweets
containing nine anti-authority words. This may be due to the differing
influence of Confucian verses European enlightenment values in defining
attitudes towards individual liberty.

Yet on the other hand, given how a large portion of Sinic users heavily
criticize the recent military coup in Myanmar, these findings could also
represent the growing use of hyperbolic language among increasingly
split hierarchical and pro-democracy orientated groups in the far East.
The Sinic world may thus be both culturally hierarchical and
experiencing the consolidation of democratic values.

The rest of the report is organized into the following sections:

1)  Authorianism
2)  Sentiment Analysis

 

## **1: Authorianism**

1.1: Power distance scores in Hofstede’s seminal cultural dimension’s
study. Power distance is the extent to which people accept unequal power
and authority in society *(Hofstede, 1980)*.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

1.2: Aspects of democracy according to The Economist Intelligence Unit’s
Democracy Index *(EIU, 2020)*.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

 

## **2: Sentiment Analysis**

The tweets are collected within a 50 mile range of the Anglophone (the
US, the UK, Canada, Australia, New Zealand and South Africa) and Sinic
(China, Vietnam, Taiwan, South Korea, Hong Kong and Singapore) country
capitals from the 11th of May 2021 to present. A sentiment analysis is
then conducted using the NRC sentiment library.

The anti-authority words include 1) defy, 2) disobey, 3) dissent, 4)
oppose, 5) protest, 6) rebel, 7) resist, 8) revolt and 9) riot.

Figures 2.1 to 2.2 show the scores for specific emotions across the
combined anti-authority tweet collection, while figures 2.3 to 2.5 show
net sentiment (positive minus negative scores). The results are
presented as bar charts with each bar representing a different week.

<br>

### Summary Statistics:

| Region | Tweets (000s) | Tweets (%) |
| :----: | :-----------: | :--------: |
| Anglo  |      142      |    31.8    |
| Sinic  |      303      |    68.2    |
| Total  |      445      |   100.0    |

 

### Specific Emotions:

2.1: The scores for selected positive emotions across the combined
anti-authority tweet collection.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

2.2: The scores for selected negative emotions across the combined
anti-authority tweet collection.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

### Net Sentiment:

2.3: The overall net sentiment. Net sentiment is calculated as positive
minus negative words expressed as a percentage of the overall total.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

2.4: The net sentiment for each country. Net sentiment is calculated as
positive minus negative words expressed as a percentage of the country
total.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

2.5: The net sentiment for each search term. Net sentiment is calculated
as positive minus negative words expressed as a percentage of search
term total.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

 

## **Sources**

  - EIU (2020) <https://www.eiu.com/n/campaigns/democracy-index-2020/>

  - Hofstede (1980)
    <https://www.tandfonline.com/doi/abs/10.1080/00208825.1980.11656300?journalCode=mimo20>

  - Mohammad (2021)
    <https://saifmohammad.com/WebPages/NRC-Emotion-Lexicon.htm>

  - Twitter (2021) <https://developer.twitter.com/en/apply-for-access>
