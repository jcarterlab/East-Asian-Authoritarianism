Rebel Without a Cause
================
Jack Carter
13/10/2021

## **Summary**

This project analyzes a corpus of over 900,000 tweets containing, or in
response to those containing, a range of anti-authority words. It aims
to test whether there are systematic differences in anti-authority
sentiment between Anglosphere and Sinosphere Twitter users. It finds
that negative sentiment is significantly higher among Sinosphere users,
potentially indicating a deep rooted cultural difference in attitudes to
authority. These results could also however be due to other factors,
such as the more limited use of anti-authority words in everyday,
non-emotive langauge for those whose mother tongue is not English.

 

## **Method**

**1) Terms:**

The tweets contain or are in response to those containing one or more of
nine anti-authority terms, including defy, disobey, dissent, oppose,
protest, rebel, resist, revolt and riot.

<br/>

**2) Countries:**

The Anglosphere countries include Australia, Canada, New Zealand, South
Africa, the UK and the US. The Sinosphere countries include China, Hong
Kong, Singapore, South Korea, Taiwan and Vietnam.

<br/>

**3) Data Collection:**

The tweets are collected using Twitter location data from within a 50
mile range of the respective country capitals every week from the 11th
of May to present. They are then cleaned to exclude duplicates,
eliminate stopwords and remove punctuation.

<br/>

**4) Net Sentiment:**

Net sentiment is calculated as the total share of positive minus
negative words. It is then expressed as a percentage of all words by
relevant faceting variables, taking into account differences in the
volume of and number of words in tweets.

 

## Results

### **1) Sphere:**

<br/>

**Tweets (000s)**

<table>

<thead>

<tr>

<th style="text-align:right;">

Anglo

</th>

<th style="text-align:right;">

Sino

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

378

</td>

<td style="text-align:right;">

545

</td>

</tr>

</tbody>

</table>

![](Rebel-Without-a-Cause_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

### **2) Term:**

<br/>

**Tweets (000s)**

<table>

<thead>

<tr>

<th style="text-align:right;">

Defy

</th>

<th style="text-align:right;">

Disobey

</th>

<th style="text-align:right;">

Dissent

</th>

<th style="text-align:right;">

Oppose

</th>

<th style="text-align:right;">

Protest

</th>

<th style="text-align:right;">

Rebel

</th>

<th style="text-align:right;">

Resist

</th>

<th style="text-align:right;">

Revolt

</th>

<th style="text-align:right;">

Riot

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

36

</td>

<td style="text-align:right;">

3

</td>

<td style="text-align:right;">

10

</td>

<td style="text-align:right;">

70

</td>

<td style="text-align:right;">

624

</td>

<td style="text-align:right;">

39

</td>

<td style="text-align:right;">

67

</td>

<td style="text-align:right;">

15

</td>

<td style="text-align:right;">

59

</td>

</tr>

</tbody>

</table>

![](Rebel-Without-a-Cause_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

### **3) Country:**

<br/>

**Tweets (000s)**

<table>

<thead>

<tr>

<th style="text-align:right;">

Australia

</th>

<th style="text-align:right;">

Canada

</th>

<th style="text-align:right;">

China

</th>

<th style="text-align:right;">

Hong Kong

</th>

<th style="text-align:right;">

New Zealand

</th>

<th style="text-align:right;">

Singapore

</th>

<th style="text-align:right;">

South Africa

</th>

<th style="text-align:right;">

South Korea

</th>

<th style="text-align:right;">

Taiwan

</th>

<th style="text-align:right;">

UK

</th>

<th style="text-align:right;">

US

</th>

<th style="text-align:right;">

Vietnam

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

8

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

20

</td>

<td style="text-align:right;">

2

</td>

<td style="text-align:right;">

489

</td>

<td style="text-align:right;">

30

</td>

<td style="text-align:right;">

34

</td>

<td style="text-align:right;">

1

</td>

<td style="text-align:right;">

173

</td>

<td style="text-align:right;">

162

</td>

<td style="text-align:right;">

0

</td>

</tr>

</tbody>

</table>

![](Rebel-Without-a-Cause_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

### **4) Week:**

<br/>

**Tweets (000s)**

<table>

<thead>

<tr>

<th style="text-align:right;">

1

</th>

<th style="text-align:right;">

2

</th>

<th style="text-align:right;">

3

</th>

<th style="text-align:right;">

4

</th>

<th style="text-align:right;">

5

</th>

<th style="text-align:right;">

6

</th>

<th style="text-align:right;">

7

</th>

<th style="text-align:right;">

8

</th>

<th style="text-align:right;">

9

</th>

<th style="text-align:right;">

10

</th>

<th style="text-align:right;">

11

</th>

<th style="text-align:right;">

12

</th>

<th style="text-align:right;">

13

</th>

<th style="text-align:right;">

14

</th>

<th style="text-align:right;">

15

</th>

<th style="text-align:right;">

16

</th>

<th style="text-align:right;">

17

</th>

<th style="text-align:right;">

18

</th>

<th style="text-align:right;">

19

</th>

<th style="text-align:right;">

20

</th>

<th style="text-align:right;">

21

</th>

<th style="text-align:right;">

22

</th>

<th style="text-align:right;">

23

</th>

<th style="text-align:right;">

24

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

60

</td>

<td style="text-align:right;">

57

</td>

<td style="text-align:right;">

49

</td>

<td style="text-align:right;">

55

</td>

<td style="text-align:right;">

53

</td>

<td style="text-align:right;">

65

</td>

<td style="text-align:right;">

62

</td>

<td style="text-align:right;">

56

</td>

<td style="text-align:right;">

59

</td>

<td style="text-align:right;">

54

</td>

<td style="text-align:right;">

41

</td>

<td style="text-align:right;">

31

</td>

<td style="text-align:right;">

27

</td>

<td style="text-align:right;">

31

</td>

<td style="text-align:right;">

26

</td>

<td style="text-align:right;">

27

</td>

<td style="text-align:right;">

21

</td>

<td style="text-align:right;">

22

</td>

<td style="text-align:right;">

30

</td>

<td style="text-align:right;">

25

</td>

<td style="text-align:right;">

19

</td>

<td style="text-align:right;">

19

</td>

<td style="text-align:right;">

16

</td>

<td style="text-align:right;">

18

</td>

</tr>

</tbody>

</table>

![](Rebel-Without-a-Cause_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

 

## **Sources**

  - Mohammad (2021)
    <https://saifmohammad.com/WebPages/NRC-Emotion-Lexicon.htm>

  - Twitter (2021) <https://developer.twitter.com/en/apply-for-access>
