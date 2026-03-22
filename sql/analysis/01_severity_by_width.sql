-- Check for road_width distribution
SELECT DISTINCT road_width,
COUNT(*)
FROM accidents_cleaned
GROUP BY road_width
ORDER BY road_width;

-- Create column with road_width bins based on distribution
ALTER TABLE accidents_cleaned
ADD COLUMN width_category TEXT;
UPDATE accidents_cleaned
SET width_category = CASE
    WHEN road_width <= 5 THEN '≤5 m'
    WHEN road_width <= 8 THEN '6-8 m'
    WHEN road_width <= 11 THEN '9-11 m'
    WHEN road_width <= 14 THEN '12-14 m'
    ELSE '15+ m'
END;

-- Check for deaths rate per road width category
SELECT
    width_category,
    COUNT(*) AS total_accidents,
    SUM(CASE WHEN deaths > 0 THEN 1 ELSE 0 END) AS fatal_accidents,
    SUM(CASE WHEN deaths = 0 THEN 1 ELSE 0 END) AS non_fatal_accidents,
    ROUND(100.0 * SUM(CASE WHEN deaths > 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS fatal_rate_percent
FROM accidents_cleaned
GROUP BY width_category
ORDER BY CASE
    WHEN width_category = '≤5 m' THEN 1
    WHEN width_category = '6-8 m' THEN 2
    WHEN width_category = '9-11 m' THEN 3
    WHEN width_category = '12-14 m' THEN 4
    ELSE 5
END;
