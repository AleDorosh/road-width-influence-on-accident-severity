-- Check if all accident_id are same length
SELECT 
DISTINCT len(accident_id)
FROM accidents_filtered;

-- Check range of numerical values 
SELECT 
MAX(deaths) AS max_death,
MIN(deaths) AS min_death, 
MAX(injured) AS max_injured,
MIN(injured) AS min_injured,
MAX(road_width) AS max_road_width,
MIN(road_width) AS min_road_width,
MAX(speed_limit) AS max_speed_limit, 
MIN(speed_limit) AS min_speed_limit, 
MAX(join_distance) AS max_join_distance,
MIN(join_distance) AS min_join_distance
FROM accidents_filtered;


-- Check distribution of injured
SELECT 
    injured,
    COUNT(*) AS count
FROM accidents_filtered
GROUP BY injured
ORDER BY injured;

-- Check unrealistic values
SELECT *
FROM accidents_filtered
WHERE injured IN (6, 7, 9, 15);

-- Remove unrealistic values
DELETE
FROM accidents_filtered
WHERE injured = 15 OR (injured = 7 AND accident_type = 'Jalakäijaõnnetus');

-- Check distribution of speed_limit
SELECT 
    speed_limit,
    COUNT(*) AS count
FROM accidents_filtered
GROUP BY speed_limit
ORDER BY speed_limit;

-- Check unrealistic value
SELECT *
FROM accidents_filtered
WHERE speed_limit IN (5, 10, 90, 110);

-- Remove unrealistic values 
DELETE
FROM accidents_filtered
WHERE speed_limit IN (90, 110);

-- Check distribution of road_width
SELECT 
    road_width,
    COUNT(*) AS count
FROM accidents_filtered
GROUP BY road_width
ORDER BY road_width;

-- Check unrealistic value
SELECT *
FROM accidents_filtered
WHERE road_width IN (25, 35);

-- Remove unrealistic values
DELETE
FROM accidents_filtered
WHERE road_width = 35;

-- Check string columns
SELECT 'county' AS column_name, county AS value, COUNT(*) 
FROM accidents_filtered GROUP BY county
UNION ALL
SELECT 'municipality', municipality, COUNT(*)
FROM accidents_filtered GROUP BY municipality
UNION ALL
SELECT 'settlement', settlement, COUNT(*)
FROM accidents_filtered GROUP BY settlement 
UNION ALL
SELECT 'accident_type', accident_type, COUNT(*)
FROM accidents_filtered GROUP BY accident_type 
UNION ALL
SELECT 'accident_type_detailed', accident_type_detailed, COUNT(*)
FROM accidents_filtered GROUP BY accident_type_detailed 
UNION ALL
SELECT 'accident_scenario', accident_scenario, COUNT(*)
FROM accidents_filtered GROUP BY accident_scenario 
UNION ALL
SELECT 'road_type', road_type, COUNT(*)
FROM accidents_filtered GROUP BY road_type 
UNION ALL
SELECT 'road_type_detailed', road_type_detailed, COUNT(*)
FROM accidents_filtered GROUP BY road_type_detailed 
UNION ALL
SELECT 'road_condition', road_condition, COUNT(*)
FROM accidents_filtered GROUP BY road_condition 
UNION ALL
SELECT 'road_surface_condition', road_surface_condition, COUNT(*)
FROM accidents_filtered GROUP BY road_surface_condition
UNION ALL
SELECT 'weather', weather, COUNT(*)
FROM accidents_filtered GROUP BY weather
UNION ALL
SELECT 'lighting', lighting, COUNT(*)
FROM accidents_filtered GROUP BY lighting
ORDER BY column_name, value;

-- Replace Pole teada, Teadmata etc values in secondary columns with UNKNOWN
UPDATE accidents_filtered
SET accident_scenario = 'Unknown'
WHERE accident_scenario = 'Tundmatu liikluskonflikt.';

UPDATE accidents_filtered
SET lighting = 'Unknown'
WHERE lighting = 'Teadmine puudub';

UPDATE accidents_filtered
SET road_condition = 'Unknown'
WHERE road_condition = 'Teadmine puudub';

UPDATE accidents_filtered
SET road_surface_condition = 'Unknown'
WHERE road_surface_condition = 'Pole teada';

UPDATE accidents_filtered
SET weather = 'Unknown'
WHERE weather = 'Pole teada';

-- Create new dataset containing cleaned data
CREATE TABLE accidents_cleaned AS
SELECT *
FROM accidents_filtered;

-- Check if all rows were imported
SELECT COUNT(*)
FROM accidents_cleaned;

SELECT *
FROM accidents_cleaned
LIMIT 200;
