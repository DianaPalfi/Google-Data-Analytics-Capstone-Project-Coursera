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


--  ![image](https://github.com/DianaPalfi/Google-Data-Analytics-Capstone-Project-Coursera/assets/145564660/0ddd0433-b32f-418f-b69b-5862287dd93d)


```
SELECT COUNT(ride_id) AS total_rides,
       COUNT (DISTINCT ride_id) AS total_unique_rides
FROM `capstoneproject.trip_combined_data`;
```
