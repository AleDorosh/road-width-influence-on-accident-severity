
-- Check if all rows were imported
SELECT COUNT(*)
FROM accidents_filtered;

-- Check for duplicate rows
SELECT COUNT(*) - COUNT(DISTINCT accident_id)
FROM accidents_filtered;

-- Check found duplicate rows
SELECT *
FROM accidents_filtered
WHERE accident_id IN (3100180332990, 2101250066561);

-- Remove duplicate rows
DELETE FROM accidents_filtered
WHERE accident_id IN (
    SELECT accident_id
    FROM accidents_filtered
    GROUP BY accident_id
    HAVING COUNT(*) > 1
);
