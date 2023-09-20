-- Combine all tables

DROP TABLE IF EXISTS `capstoneproject.trip_combined_data`;

-- combining all the 12 months data tables into a single table containing data from August 2021 to July 2022.

CREATE TABLE IF NOT EXISTS `capstoneproject.trip_combined_data` AS (
  SELECT * FROM `capstoneproject.202108-divvy-tripdata`
  UNION ALL
  SELECT * FROM `capstoneproject.202109-divvy-tripdata`
  UNION ALL
  SELECT * FROM `capstoneproject.202110-divvy-tripdata`
  UNION ALL
  SELECT * FROM `capstoneproject.202111-divvy-tripdata`
  UNION ALL
  SELECT * FROM `capstoneproject.202112-divvy-tripdata`
  UNION ALL
  SELECT * FROM `capstoneproject.202201-divvy-tripdata`
  UNION ALL
  SELECT * FROM `capstoneproject.202202-divvy-tripdata`
  UNION ALL
  SELECT * FROM `capstoneproject.202203-divvy-tripdata`
  UNION ALL
  SELECT * FROM `capstoneproject.202204-divvy-tripdata`
  UNION ALL
  SELECT * FROM `capstoneproject.202205-divvy-tripdata`
  UNION ALL
  SELECT * FROM `capstoneproject.202206-divvy-tripdata`
  UNION ALL
  SELECT * FROM `capstoneproject.202207-divvy-tripdata`
);


SELECT COUNT(*)
FROM `capstoneproject.trip_combined_data`;