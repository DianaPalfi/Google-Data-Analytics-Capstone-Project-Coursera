--this code is different from the overall code because i added a rider_count column with integer format and a total_ride_length where we have the time calculated in minutes

WITH count_total_riders AS (
SELECT 
ride_id,
 started_at, 
 rideable_type,
 member_casual,
 start_station_name,
 end_station_name,
 end_lat,
 end_lng,
 started_at,
 ended_at,
 ride_length,
 CASE WHEN member_casual IS NOT NULL THEN 1 ELSE 0 END AS rider_count
FROM `aqueous-flames-342615.capstoneproject.cleaned_trip_combined_data` 
)

SELECT 
    *
FROM count_total_riders a
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
    total_ride_length > 1 AND total_ride_length < 1440;

