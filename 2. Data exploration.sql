--check duplicate values for primary key column, ride_id. -> there are no duplicate values for ride_id as the number of ride_id = total_unique_rides (5901463)
SELECT COUNT(ride_id) AS total_rides,
       COUNT (DISTINCT ride_id) AS total_unique_rides
FROM `capstoneproject.trip_combined_data`;


--there are no null values for ride id column
SELECT ride_id
FROM `capstoneproject.trip_combined_data`
WHERE ride_id IS NULL;   


--check number of trips per rideable type
SELECT DISTINCT rideable_type, COUNT(rideable_type) AS no_of_trips
FROM `capstoneproject.trip_combined_data`
GROUP BY rideable_type;


--added a new column, ride_length to calculate the ride length of the trips
ALTER TABLE  `capstoneproject.trip_combined_data`
ADD COLUMN ride_length INTERVAL;

UPDATE `capstoneproject.trip_combined_data`
SET ride_length = (ended_at - started_at) 
WHERE ride_id IS NOT NULL;


--check min ride_length
SELECT (ended_at - started_at) AS ride_length,
        MIN (ride_length)
FROM `capstoneproject.trip_combined_data` 


--check min,max and average ride length. Mininum function has negative value.
SELECT MIN(ride_length) AS min_ride_length,
      MAX(ride_length) AS max_ride_length,
      AVG(ride_length) AS average_ride_length
FROM `capstoneproject.trip_combined_data`;


--check ride lenghs value > 1day & <1 min
SELECT COUNT(*) AS longer_than_a_day
FROM `capstoneproject.trip_combined_data`
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) >= 1440; -- longer than a day - total rows = 4966

SELECT COUNT(*) AS less_than_a_minute
FROM `capstoneproject.trip_combined_data`
WHERE (
  EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
  EXTRACT(MINUTE FROM (ended_at - started_at)) +
  EXTRACT(SECOND FROM (ended_at - started_at)) / 60) <= 1; --less than 1 min - total rows = 105613

--check the null rows in start_station_name and start_station_id
SELECT DISTINCT start_station_name
FROM `capstoneproject.trip_combined_data`
ORDER BY start_station_name; 

SELECT COUNT(ride_id) AS start_station_null          -- return 860786 rows
FROM `capstoneproject.trip_combined_data`
WHERE start_station_name IS NULL OR start_station_id IS NULL;

SELECT COUNT(ride_id) AS start_station_null          
FROM `capstoneproject.trip_combined_data`
WHERE start_station_name IS NULL OR start_station_id IS NULL; 

--check the null rows in end_station_name and end_station_id
SELECT COUNT(ride_id) AS end_station_null          -- return 919896 rows
FROM `capstoneproject.trip_combined_data`
WHERE end_station_name IS NULL OR end_station_id IS NULL;

--check number of rides per member type: annual and casual
SELECT member_casual, 
      COUNT (member_casual) AS member_trips
FROM `capstoneproject.trip_combined_data`
GROUP by member_casual

--check types of rides for casual members
SELECT rideable_type,
      COUNT(rideable_type) AS no_ride_type
FROM `capstoneproject.trip_combined_data`
WHERE member_casual = 'casual'
GROUP BY rideable_type;