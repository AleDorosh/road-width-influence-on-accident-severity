-- Check for accident type per road width
SELECT 
    width_category,
    accident_type,
    COUNT(*) AS total_accidents,
    SUM(CASE WHEN deaths > 0 THEN 1 ELSE 0 END) AS fatal_accidents,
    ROUND(100.0 * SUM(CASE WHEN deaths > 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS fatal_rate_percent
FROM accidents_cleaned
GROUP BY width_category, accident_type
ORDER BY CASE
    WHEN width_category = '≤5 m' THEN 1
    WHEN width_category = '6-8 m' THEN 2
    WHEN width_category = '9-11 m' THEN 3
    WHEN width_category = '12-14 m' THEN 4
    ELSE 5
END,
fatal_rate_percent DESC;
