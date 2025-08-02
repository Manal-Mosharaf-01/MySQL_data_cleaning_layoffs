SELECT *
FROM world_layoffs_new.layoffs;

-- 1. Remove duplicates
-- 2. Standarization of data like spelling and stuff
-- 3. Null values or blank values
-- 4. Remove any columns

											-- Step 1. Remove duplicates from world_layoffs1

-- Read world_layoffs1 main table layoffs
SELECT *
FROM world_layoffs_new.layoffs;

-- Create a new table similar to layoffs (staging)
CREATE TABLE layoffs_staging
LIKE world_layoffs_new.layoffs;

-- Check if table row is created like layoffs (there wont be any data in it, only the table is created)
SELECT *
FROM world_layoffs_new.layoffs_staging
ORDER BY company;

-- Insert the data into the staging table

INSERT INTO world_layoffs_new.layoffs_staging
(
SELECT *
FROM world_layoffs_new.layoffs
);

-- Read the new staging table
SELECT *
FROM world_layoffs_new.layoffs_staging;

-- Now Find duplicates

SELECT company,funds_raised_millions, AVG (funds_raised_millions) OVER ()
FROM world_layoffs_new.layoffs_staging;

-- we will give each row unique number
SELECT *, 
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions
) AS number_of_row
FROM world_layoffs_new.layoffs_staging ORDER BY number_of_row, company;

-- Check if more than one rows (check duplicate)

WITH duplicate_CTE AS
(
SELECT *, 
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions
) AS number_of_row
FROM world_layoffs_new.layoffs_staging ORDER BY number_of_row, company
)
SELECT *
FROM duplicate_CTE
WHERE number_of_row > 1;

-- Delete the duplicates (this will not work)

WITH duplicate_CTE AS
(
SELECT *, 
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions
) AS number_of_row
FROM world_layoffs_new.layoffs_staging ORDER BY number_of_row, company
)
DELETE
FROM duplicate_CTE
WHERE number_of_row > 1;

-- Delete the duplicates (by creating a new table and add row number as a collumn)
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM world_layoffs_new.layoffs_staging2;

-- insert data into the new table
INSERT INTO world_layoffs_new.layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER (
PARTITION BY company, location, industry, total_laid_off, `date`, stage, country, funds_raised_millions
) AS number_of_row
FROM world_layoffs_new.layoffs_staging ORDER BY number_of_row, company;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- We have 2356 data in this new table without any duplicate
SELECT *
FROM world_layoffs_new.layoffs_staging2;

									-- 2. Standarization of data like spelling and stuff
SELECT *
FROM world_layoffs_new.layoffs_staging2;

-- Trimming usage

SELECT company, TRIM(company)
FROM world_layoffs_new.layoffs_staging2;

-- update trimmed data
UPDATE world_layoffs_new.layoffs_staging2
SET company = TRIM(company);

SELECT company, TRIM(company)
FROM world_layoffs_new.layoffs_staging2;



SELECT industry
FROM world_layoffs_new.layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE world_layoffs_new.layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT *
FROM world_layoffs_new.layoffs_staging2
ORDER BY 2;



SELECT DISTINCT location
FROM world_layoffs_new.layoffs_staging2
order by 1;



SELECT DISTINCT country
FROM world_layoffs_new.layoffs_staging2
order by 1;

UPDATE world_layoffs_new.layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

UPDATE world_layoffs_new.layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


-- change date format
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM world_layoffs_new.layoffs_staging2;

UPDATE world_layoffs_new.layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT *
FROM world_layoffs_new.layoffs_staging2;

-- change it from text to date collumn (usage of ALTER)

ALTER TABLE world_layoffs_new.layoffs_staging2
MODIFY COLUMN `date` DATE; 




											-- 3. Null values or blank values

SELECT *
FROM world_layoffs_new.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Find where industry is null or missing a value
SELECT *
FROM world_layoffs_new.layoffs_staging2
WHERE industry = ''
OR industry IS NULL;

-- populate the value from where company and location name is same
SELECT *
FROM world_layoffs_new.layoffs_staging2
WHERE company = 'Airbnb'
AND location = 'SF Bay Area';

SELECT * 
FROM world_layoffs_new.layoffs_staging2
WHERE company = 'Carvana'
AND location = 'Phoenix'
ORDER BY industry DESC;

SELECT *
FROM world_layoffs_new.layoffs_staging2
WHERE industry = ''
OR industry IS NULL;

SELECT *
FROM world_layoffs_new.layoffs_staging2 AS t1
JOIN  world_layoffs_new.layoffs_staging2 AS t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE world_layoffs_new.layoffs_staging2
SET industry = null
WHERE industry = '';

UPDATE world_layoffs_new.layoffs_staging2 AS t1
JOIN  world_layoffs_new.layoffs_staging2 AS t2
	ON t1.company = t2.company
    AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;



									-- Step 4. Remove any columns
                                    

SELECT *
FROM world_layoffs_new.layoffs_staging2;

SELECT *
FROM world_layoffs_new.layoffs_staging2
WHERE (total_laid_off IS NULL AND percentage_laid_off IS NULL)
OR (total_laid_off ='' AND percentage_laid_off = '');

DELETE
FROM world_layoffs_new.layoffs_staging2
WHERE (total_laid_off IS NULL AND percentage_laid_off IS NULL)
OR (total_laid_off ='' AND percentage_laid_off = '');

ALTER TABLE world_layoffs_new.layoffs_staging2
DROP COLUMN row_num;
