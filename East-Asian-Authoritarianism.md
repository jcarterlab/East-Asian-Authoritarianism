East-Asian-Authoritarianism
================
Jack Carter
4/10/2021

## **Summary**

This report analyzes attitudes towards individual liberty between Sinic
and Anglophone countries. It finds that Sinic country Twitter users
demonstrate less positive sentiment when using freedom and a collection
of anti-authority words. This may be due to the differing influence of
Confucian verses European enlightenment values.

It could also however be the result of a difference in context. Many
people in Hong Kong and Taiwan for instance likely tweet negatively
about their own freedoms given China’s growing regional assertiveness.
South East Asian countries such as Singapore may also be more likely to
tweet negatively about the tragic loss of freedom in neighboring Myanmar
following a recent military coup.

The rest of the report is organized into the following sections:

1.  The Current Situation
2.  Sentiment Analysis

 

## **1. The Current Situation**

1.1: Overall democracy scores according to The Economist Intelligence
Unit *(EIU, 2020)*.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

1.2: Aspects of democracy scores according to The Economist Intelligence
Unit *(EIU, 2020)*.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

1.3: Power distance scores, the extent to which people accept unequal
power in society *(Hofstede, 1980)*.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

 

## **2. Sentiment Analysis**

The analysis collects tweets from within a 50 mile range of respective
country capitals. A sentiment analysis is then conducted using the NRC
library. This is done by calculating how often words associated with
certain sentiments occur relative to their regional total.

 

### Summary Statistics:

|   Region   | Tweets (000s) | Words (000s) | Tweets (%) | Words (%) |
| :--------: | :-----------: | :----------: | :--------: | :-------: |
| Anglophone |      152      |     2811     |    51.3    |   46.7    |
|   Sinic    |      144      |     3208     |    48.7    |   53.3    |

 

2.1 The net sentiment for freedom. Net sentiment is calculated as
positive minus negative words.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

2.4 The net sentiment for anti-authority words, including those related
to protest, rebel, revolt and riot.

![](East-Asian-Authoritarianism_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

 

## **Sources**

  - EIU (2020) <https://www.eiu.com/n/campaigns/democracy-index-2020/>

  - Hofstede (1980)
    <https://www.tandfonline.com/doi/abs/10.1080/00208825.1980.11656300?journalCode=mimo20>

  - Mohammad (2021)
    <https://saifmohammad.com/WebPages/NRC-Emotion-Lexicon.htm>

  - Twitter (2021) <https://developer.twitter.com/en/apply-for-access>
