# Google-Data-Analytics-Capstone-Project-Coursera

Course: [Google Data Analytics Professional Certifcate](https://www.coursera.org/professional-certificates/google-data-analytics)

**Introduction**

In this case study, I will perform data analysis for a fictional bike-share company in order to help them attract more riders by performing real-world tasks of a junior data analyst. To answer business questions, I will follow the steps of the data analysis process: Ask, Prepare, Process, Analyze, Share, and Act.

**Background**

Cyclystic is a bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.
The company was founded in 2016 in Chicago and since then Cyclistic has grown to a fleet of 5,824 bycycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime. In order to appeal to broad consumer segments, the company offers flexible pricing plans:

 - single-ride passes
 - full-day passes
 - annual memberships


The director of marketing, Lily Moreno, wants to design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.
### Ask

Three questions will guide the future marketing program:

1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

Moreno has assigned me the first question to answer: _How do annual members and casual riders use Cyclistic bikes differently?_

***
### Prepare

I used Cyclistic’s historical trip data to analyze and identify trends, which were mage available by by Motivate International Inc. under this
[license](https://divvybikes.com/data-license-agreement). The data needed for this analysis can be downloaded from [divvy-tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html). This is public data that you can use to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit you from using riders’ personally identifiable information. This means that you won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.
To fulfill this analysis, I downloaded the historical trip data to analyze from August 2021 to July 2022.

Cyclistic's data is stored in multiple CSV files and the column names in each cvs file are the same:

| column_name	| data_type |
|-------------|-----------|
| ride_id	| STRING |
| rideable_type	| STRING |
| started_at	| TIMESTAMP |
| ended_at	| TIMESTAMP |
| start_station_name	| STRING |
| start_station_id	| STRING |
| end_station_name	| STRING |
| end_station_id	| STRING |
| start_lat	| FLOAT64 |
| start_lng	| FLOAT64 |
| end_lat	| FLOAT64 |
| end_lng	| FLOAT64 |
| member_casual |	STRING |
 
***
### Process

Cyclistic trip data will be processed in BigQuery due to the size of the CSV files it is easier to manipulate the data in a SQL query.

_Data merge_

The first step is to merge all the data from 12 CSV files into a single table which will be named 'trip_combined_data' located in the dataset 'capstoneproject'. I also added another column 'ride_lenth' to calculate the length of each ride.

```
ALTER TABLE  `capstoneproject.trip_combined_data`
ADD COLUMN ride_length INTERVAL;

UPDATE `capstoneproject.trip_combined_data`
SET ride_length = (ended_at - started_at) 
WHERE ride_id IS NOT NULL;
```

### Analyze
_Data exploration_
> 1. Duplicate check

As ride_id is our primary key we need to check if the total number of ride_id is the same with unique ride_ids in the new merged table 'trip_combined_data', which means that there are no duplicate values.
| total_rides	| total_unique_rides |
|-------------|-----------|
|5901463 | 5901463 |

>2. Check null values

Not all rows are populated with data, which led me to checkhow many columns have missing data. I checeked ride_id, start_station_name, end_station_name, start_station_id, end_station_id, and found out the following:
-  start_station_name or start_station_id have 860,786 null rows
-  end_station_name or end_station_id have 919,896 null rows

>3. Check min/max/average ride length data

In order to undertand better the data that we have, i checked min, max and average data of the ride length.

| min_ride_length	| max_ride_length | average_ride_length |
|-----------------|-----------------|---------------------|
| 0-0 0 -2:17:25 | 0-0 0 693:49:10 | 0-0 0 0:19:53.37|

>4.Check number of rides by member trips.

| member_casual | member_trips |
|---------------|--------------|
| casual | 2,522,226 |
| member | 3,379,237 |

>5.Check number of trips per rideable type both for member and casual members.

| rideable_type | no_of_trips |
|---------------|--------------|
| electric_bike | 2,619,094 |
| classic_bike | 3,055,641 |
| docked_bike | 226,728 |


>6. Check types of rides for **casual** members

| rideable_type | no_ride_trips |
|---------------|--------------|
| electric_bike | 1,162,606 |
| classic_bike | 1,132,892 |
| docked_bike | 226,728 |

_Data cleaning_
- create a new table with the cleaned data 'cleaned_trip_combined_data'
- add columns and data types for these columns
- import the data into the newly created table
- extract the month and day of the week
- delete the empty rows from the following columns: start_station_name, end_station_name, end_lat, end_lng --> 1,342,578 rows were deleted
- exclude trips which lasted less than 1 minute and longer than a day

### Share
Big Query: 4. Data analysis.sql
Data Vizualization: 
After the data was cleaned I uploaded the downloaded csv file from Big Query to Tableau and created visualizations to help me understand the data for the two member types: casual and member. 
I created line charts in order to see the pattern of trips per month and per week. 

**Monthly**: Members display a higher number of trips every single month of the year with the exception of August when casual members show a slight growth in the number of trips. Both member types  show a growth in the total number of trips from May to October.
![image](https://github.com/DianaPalfi/Google-Data-Analytics-Capstone-Project-Coursera/assets/145564660/442bdbe6-aafd-4377-8bf7-d07b5ff8129f)

**Weekly**: Comparing the trips by days of week, casual riders take more trips during the weekend than member riders, while members have more trips from Monday to Friday.
![image](https://github.com/DianaPalfi/Google-Data-Analytics-Capstone-Project-Coursera/assets/145564660/123c25a6-c548-4608-918e-ae5d6d879e48)

From this data we can assume that casual riders use bikes for leaisure during the weekends and mostly during summer months, while members use bikes to commute during the week. Both member types display the same pattern, as they use bikes more during warmer months, more specifically from April to October.

**Average trips**
Average trips per month: The casual member average bike ride per month ranges from 18 min 25 sec to 27 min 99 sec while members average cycling time is much lower from 10 min 41 sec to 13 min 93 sec. 
![image](https://github.com/DianaPalfi/Google-Data-Analytics-Capstone-Project-Coursera/assets/145564660/9b88083c-707f-4f65-85ca-db4dee25025b)

Avreage trips per week: Member rider average time does not change much during the week , while casual members ride bikes twice as much, with a visible increase during the weekends.
![image](https://github.com/DianaPalfi/Google-Data-Analytics-Capstone-Project-Coursera/assets/145564660/5f7009dc-34bc-4536-afe9-27b8e274545c)

**Start stations**
Members started their trips from stations close to university, reasidential areas, schools, banks while casual riders frequently started their trips nearby museums and parks.
![image](https://github.com/DianaPalfi/Google-Data-Analytics-Capstone-Project-Coursera/assets/145564660/5ac6f3a2-4fa2-4ffc-adbb-47e77adc5f5c)


**End stations**
The same pattern can be observed for end stations locations for borh member types.
![image](https://github.com/DianaPalfi/Google-Data-Analytics-Capstone-Project-Coursera/assets/145564660/1a0c9fd1-e667-4892-9993-de8347ca550e)


**Top 10 Start / End stations**
![image](https://github.com/DianaPalfi/Google-Data-Analytics-Capstone-Project-Coursera/assets/145564660/4f9d144a-de6f-495a-b730-cfb43506650e)
![image](https://github.com/DianaPalfi/Google-Data-Analytics-Capstone-Project-Coursera/assets/145564660/34cef82e-9142-4c80-9022-160170215057)
The top 10 stations start and end stations are mostly the same, displaying a difference in the number of rides these stations had.

### Act
As a conlusion of the analysis it was observed that members use the bike to commute during the week and casual riders use the bike service for leisure mostly during the weekend. In order to incentivize casual riders to become member the following targeted marketing campaign is proposed:

 - give discounts for casual riders for week days to encourage bike usage for commuting to work/school
 - use push notifications during lean periods of the day
 - tarsget on ground marketing campaigns at points of leisure
