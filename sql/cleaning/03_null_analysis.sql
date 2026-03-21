-- Check for NULL values
SELECT 
    COUNT(*) - COUNT(accident_id) AS accident_id_nulls,
    COUNT(*) - COUNT(deaths) AS deaths_nulls,
    COUNT(*) - COUNT(injured) AS injured_nulls,
    COUNT(*) - COUNT(county) AS county_nulls,
    COUNT(*) - COUNT(municipality) AS municipality_nulls,
    COUNT(*) - COUNT(accident_type_detailed) AS accident_type_detailed_nulls,
    COUNT(*) - COUNT(accident_scenario) AS accident_scenarion_nulls, 
    COUNT(*) - COUNT(road_type) AS road_type_nulls,
    COUNT(*) - COUNT(road_type_detailed) AS road_type_detailed,
    COUNT(*) - COUNT(speed_limit) AS speed_limit_nulls, 
    COUNT(*) - COUNT(road_condition) AS road_condition_nulls, 
    COUNT(*) - COUNT(road_surface_condition) AS road_surface_condition_nulls, 
    COUNT(*) - COUNT(weather) AS weather_nulls, 
    COUNT(*) - COUNT(lighting) AS lighting_nulls, 
FROM accidents_filtered;

-- Remove rows where speed_limit is NULL
DELETE
FROM accidents_filtered
WHERE speed_limit IS NULL;

-- Check how many rows have more than one NULL value
SELECT
(accident_scenario IS NULL)::INT + (road_condition IS NULL)::INT +
(road_surface_condition IS NULL)::INT + (weather IS NULL)::INT + (lighting IS NULL)::INT +
(speed_limit IS NULL)::INT AS unknown_count,
COUNT(*)
FROM accidents_filtered
GROUP BY (accident_scenario IS NULL)::INT + (road_condition IS NULL)::INT +
(road_surface_condition IS NULL)::INT + (weather IS NULL)::INT + (lighting IS NULL)::INT +
(speed_limit IS NULL)::INT
ORDER BY unknown_count;

-- Remove all rows where more > 1 value is NULL
DELETE FROM accidents_filtered
WHERE 
(accident_scenario IS NULL)::INT + (road_condition IS NULL)::INT +
(road_surface_condition IS NULL)::INT + (weather IS NULL)::INT + (lighting IS NULL)::INT +
(speed_limit IS NULL)::INT > 1;

-- Replace NULL values in secondary columns with UNKNOWN
UPDATE accidents_filtered
SET 
    accident_scenario = COALESCE(accident_scenario, 'Unknown'),
    road_condition = COALESCE(road_condition, 'Unknown'),
    road_surface_condition = COALESCE(road_surface_condition, 'Unknown'),
    weather = COALESCE(weather, 'Unknown'),
    lighting = COALESCE(lighting, 'Unknown');
