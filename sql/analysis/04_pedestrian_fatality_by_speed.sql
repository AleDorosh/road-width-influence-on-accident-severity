-- Check for speed distribution
SELECT DISTINCT 
speed_limit,
COUNT(*)
FROM accidents_cleaned
GROUP BY speed_limit
ORDER BY speed_limit;

ALTER TABLE accidents_cleaned
DROP COLUMN speed_category;

-- Create column with road_width bins based on distribution
ALTER TABLE accidents_cleaned
ADD COLUMN speed_category TEXT;
UPDATE accidents_cleaned
SET speed_category = CASE
    WHEN speed_limit <= 30 THEN '≤30 km/h'
    WHEN speed_limit <= 50 THEN '31-50 km/h'
    ELSE '51-70 km/h'
END;


-- Check for fatal pedestrian accidents per road width at speed limits
SELECT 
    width_category,
    COUNT(*) AS total_accidents,
    SUM(CASE WHEN deaths > 0 THEN 1 ELSE 0 END) AS fatal_accidents,
    ROUND(100.0 * SUM(CASE WHEN deaths > 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS fatal_rate_percent,
    speed_category
FROM accidents_cleaned
WHERE accident_type = 'Jalakäijaõnnetus'
GROUP BY width_category, accident_type, speed_category
ORDER BY 
CASE
    WHEN width_category = '≤5 m' THEN 1
    WHEN width_category = '6-8 m' THEN 2
    WHEN width_category = '9-11 m' THEN 3
    WHEN width_category = '12-14 m' THEN 4
    ELSE 5
END,
CASE
    WHEN speed_category = '≤30 km/h' THEN 1
    WHEN speed_category = '31-50 km/h' THEN 2
    ELSE 3
END,
fatal_rate_percent DESC;
