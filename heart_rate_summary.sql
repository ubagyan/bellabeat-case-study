
-- SQL Queries for Bellabeat Case Study: Heart Rate Analysis

-- 1. Average Heart Rate Per Day Per User
SELECT Id, DATE(Time) AS Date, ROUND(AVG(Value), 2) AS AvgHeartRate
FROM heartrate
GROUP BY Id, DATE(Time)
ORDER BY Date;

-- 2. Max Heart Rate Per User
SELECT Id, MAX(Value) AS MaxHeartRate
FROM heartrate
GROUP BY Id
ORDER BY MaxHeartRate DESC;

-- 3. Heart Rate Zone Classification
SELECT
  CASE
    WHEN Value < 60 THEN 'Resting'
    WHEN Value <= 100 THEN 'Moderate'
    ELSE 'Elevated'
  END AS Zone,
  COUNT(*) AS Readings
FROM heartrate
GROUP BY Zone
ORDER BY Readings DESC;
