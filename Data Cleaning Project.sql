-- DATA CLEANING PROJECT IN MYSQL
-- Dataset: Layoffs 2022-2023
-- Goal: Clean and prepare the dataset for analysis (remove duplicates, standardize entries, fix nulls)

-- Step 1: Duplicate Removal

-- Create staging table
CREATE TABLE layoffs_staging_1 LIKE layoffs;
INSERT INTO layoffs_staging_1 SELECT * FROM layoffs;

-- Identify duplicates using ROW_NUMBER()
WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company, location, industry, total_laid_off,
                            percentage_laid_off, `date`, stage, country, funds_raised_millions
               ORDER BY company
           ) AS row_num
    FROM layoffs_staging_1
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Create cleaned table
CREATE TABLE layoffs_staging6 (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT DEFAULT NULL,
    percentage_laid_off TEXT,
    `date` TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions INT DEFAULT NULL,
    row_num INT
);

-- Populate cleaned table with row numbers
INSERT INTO layoffs_staging6
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY company, location, industry, total_laid_off,
                        percentage_laid_off, `date`, stage, country, funds_raised_millions
           ORDER BY company
       ) AS row_num
FROM layoffs_staging_1;

-- Remove duplicates (row_num > 1)
DELETE FROM layoffs_staging6
WHERE row_num > 1;

-- Step 2: Standardizing Company Names
UPDATE layoffs_staging6
SET company = TRIM(company);

-- Step 3: Standardizing Industry Values
SELECT DISTINCT industry FROM layoffs_staging6;
UPDATE layoffs_staging6
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Step 4: Cleaning Country Field (e.g., removing trailing periods)
UPDATE layoffs_staging6
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Step 5: Date Formatting
UPDATE layoffs_staging6
SET `date` = STR_TO_DATE(`date`, '%Y/%m/%d');

-- Change column type to DATE
ALTER TABLE layoffs_staging6
MODIFY COLUMN `date` DATE;

-- Step 6: Handle NULL and Blank Industry Values
UPDATE layoffs_staging6
SET industry = NULL
WHERE industry = '';

-- Fill in missing industry using self join
UPDATE layoffs_staging6 t1
JOIN layoffs_staging6 t2 ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND (t2.industry IS NOT NULL AND t2.industry != '');

-- Step 7: Remove Records with No Layoff Info
DELETE FROM layoffs_staging6
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- Final Cleanup
ALTER TABLE layoffs_staging6
DROP COLUMN row_num;
