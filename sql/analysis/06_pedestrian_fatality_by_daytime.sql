-- Check for daytime fatal pedestrian accidents at 9-11m category
SELECT 
    width_category,
    COUNT(*) AS total_accidents,
    SUM(CASE WHEN deaths > 0 THEN 1 ELSE 0 END) AS fatal_accidents,
    ROUND(100.0 * SUM(CASE WHEN deaths > 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS fatal_rate_percent,
	lighting
FROM accidents_cleaned 
WHERE width_category = '9-11 m'AND accident_type = 'Jalakäijaõnnetus'
GROUP BY width_category, accident_type, lighting 
ORDER BY 
total_accidents DESC;
