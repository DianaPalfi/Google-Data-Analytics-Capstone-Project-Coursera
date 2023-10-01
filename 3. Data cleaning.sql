-- create new table with clean data
DROP TABLE IF EXISTS `capstoneproject.cleaned_trip_combined_data`;

-- creating new table and adding the columns and data types

CREATE TABLE IF NOT EXISTS `capstoneproject.cleaned_trip_combined_data`
(ride_id STRING,
 rideable_type STRING,
 started_at TIMESTAMP,
 ended_at TIMESTAMP,
  start_station_name STRING,
  end_station_name STRING, 
  start_lat FLOAT64, 
  start_lng FLOAT64,
  end_lat FLOAT64,
  end_lng FLOAT64,
  member_casual STRING,
  ride_length INTERVAL);

--inserting the data into the newly created table 

INSERT INTO `capstoneproject.cleaned_trip_combined_data`
SELECT ride_id,rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual,ride_length
FROM `capstoneproject.trip_combined_data`;


--clean the data by adding two new columns day_of_week and month and deleting the column which have empty rows

  SELECT 
    a.ride_id, rideable_type, started_at, ended_at, 
    ride_length,
    CASE EXTRACT(DAYOFWEEK FROM started_at) 
      WHEN 1 THEN 'SUN'
      WHEN 2 THEN 'MON'
      WHEN 3 THEN 'TUES'
      WHEN 4 THEN 'WED'
      WHEN 5 THEN 'THURS'
      WHEN 6 THEN 'FRI'
      WHEN 7 THEN 'SAT'    
    END AS day_of_week,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS month,
    start_station_name, end_station_name, 
    start_lat, start_lng, end_lat, end_lng, member_casual
  FROM `capstoneproject.cleaned_trip_combined_data` a
  JOIN (
    SELECT ride_id, (
      EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
      EXTRACT(MINUTE FROM (ended_at - started_at)) +
      EXTRACT(SECOND FROM (ended_at - started_at)) / 60) AS total_ride_length
    FROM `capstoneproject.trip_combined_data`
  ) b 
  ON a.ride_id = b.ride_id
  WHERE 
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    total_ride_length > 1 AND total_ride_length < 1440
;