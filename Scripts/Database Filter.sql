-- SELECT * FROM 
-- metadata;
-- Analysis conducted in MySQL

SELECT COUNT(*)
FROM metadata
WHERE Region = "UK";

SELECT DISTINCT Region
FROM metadata; 

SELECT Region, COUNT(*) AS Region_Count
FROM metadata
GROUP BY Region
ORDER BY Region;

-- Aim to filter by Stx variant -- 

SELECT Region, COUNT(*) AS Region_Count
FROM metadata
WHERE Stx = "stx2a"
GROUP BY Region
ORDER BY Region;

SELECT COUNT(*)
FROM metadata
WHERE Stx = "-";

SELECT COUNT(*)
FROM metadata
WHERE Stx = '-' 
   OR PT = '-' 
   OR Region = '-' 
   OR Country = '-' 
   OR Year = '-';

-- Certifying that missing entries == only "Stx" -- 

-- CREATE TABLE metadata_region_2 (
-- Region TEXT,
-- Counter INTEGER
-- );

DELIMITER $$ -- Temporary delimiter for ";" accuracy --

CREATE TRIGGER limit_metadata_rows
BEFORE INSERT ON metadata_region_2
FOR EACH ROW
BEGIN
	IF (SELECT COUNT(*) FROM metadata_region_2) >= 11 THEN
    SIGNAL SQLSTATE "45000" -- Custom SQL eror display -- 
    SET MESSAGE_TEXT  = "Max row number exceeded";
END IF;
END$$

DELIMITER $$;
    
INSERT INTO metadata_region_2 (Region, Counter)
VALUES 
	("UK", 2174),
    ("Australasia", 6),
    ("C. America", 29),
    ("C.Europe", 62),
    ("M.East", 157),
    ("N. Africa", 91),
    ("N. America", 12),
    ("N. Europe", 18),
    ("S. America", 3),
    ("S. Europe", 237),
    ("Subsaharan Africa", 28);
    
SELECT * FROM metadata_region_2;
