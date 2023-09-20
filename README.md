# Google-Data-Analytics-Capstone-Project-Coursera




--  ![image](https://github.com/DianaPalfi/Google-Data-Analytics-Capstone-Project-Coursera/assets/145564660/0ddd0433-b32f-418f-b69b-5862287dd93d)



SELECT COUNT(ride_id) AS total_rides,
       COUNT (DISTINCT ride_id) AS total_unique_rides
FROM `capstoneproject.trip_combined_data`;
