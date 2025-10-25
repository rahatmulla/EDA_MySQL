-- DATA CLEANING 
-- 1.Remove duplicates
-- 2.Standardize the data
-- 3.Null or Blank Values
-- 4.Remove any Columns/ rows

select *
from world_layoffs.layoffs;

-- Create a backckup table for safe cleaning, original table remains untouched
Create table world_layoffs.layoffs_staging
like world_layoffs.layoffs;

Insert layoffs_staging
select * from world_layoffs.layoffs;

-- Step 1 : Remove any duplicates

SELECT 
    *
FROM
    world_layoffs.layoffs_staging;
	
# creates a new row (row_num) , giving each row a unique number. labels duplicates.
select company, industry, total_laid_off, `date`,
row_number() OVER( PARTITION BY company,industry, total_laid_off, `date`) as row_num
from world_layoffs.layoffs_staging;

select *
from ( 	
		SELECT company, industry, total_laid_off, `date`,
			row_number() OVER( PARTITION BY company,industry, total_laid_off, `date`) as row_num
		from 
			world_layoffs.layoffs_staging
) duplicates
where
	row_num >1;
 
 -- Check with a company (ODA) to confirm
select *
from world_layoffs.layoffs_staging
where company = 'oda';

-- gives legitimate entries and shouldnt be deleted

-- these are our real duplicates
Select *
from  (
		SELECT company, location,industry, total_laid_off, percentage_laid_off,`date`, stage,country, funds_raised_millions,
			ROW_NUMBER() OVER( 
				PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage,country, funds_raised_millions
                ) AS row_num
		FROM
			world_layoffs.layoffs_staging
) duplicates
where row_num >1;

-- these are the ones we want to delete where the row number is > 1 or 2or greater essentially

WITH DELETE_CTE AS
(
SELECT *
FROM (
	SELECT company, location, industry, total_laid_off, percentage_laid_off,`date`, stage,country, funds_raised_millions,
	ROW_NUMBER() OVER( 
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,`date`, stage,country, funds_raised_millions
                ) AS row_num
		FROM
			world_layoffs.layoffs_staging
) duplicates
where row_num >1
)
DELETE
FROM DELETE_CTE
;

WITH DELETE_CTE AS (
	SELECT company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions, 
    ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
	FROM world_layoffs.layoffs_staging
)
DELETE FROM world_layoffs.layoffs_staging
WHERE (company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions, row_num) IN (
	SELECT company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions, row_num
	FROM DELETE_CTE
) AND row_num > 1;

ALTER TABLE world_layoffs.layoffs_staging ADD row_num INT;

select * 
from world_layoffs.layoffs_staging;

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
  `row_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `world_layoffs`.`layoffs_staging2`
(`company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
`row_num`)
SELECT company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions, 
    ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
	FROM world_layoffs.layoffs_staging;

select * 
from world_layoffs.layoffs_staging2
where row_num>1;

DELETE FROM world_layoffs.layoffs_staging2
WHERE row_num >= 2;


select * 
FROM world_layoffs.layoffs_staging2;

-- STANDARDIZE THE DATA

SELECT distinct(COMPANY)
FROM layoffs_staging2;

select company , trim(company)
FROM layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select * 
FROM world_layoffs.layoffs_staging2; 

select distinct industry
from layoffs_staging2
order by industry;

select *
from layoffs_staging2
where industry is NULL
or industry = '';

-- I also noticed the Crypto has multiple different variations. We need to standardize that - let's say all to Crypto
SELECT distinct industry
from layoffs_staging2
where industry like 'crypto%';

Update layoffs_staging2
set industry = 'Crypto'
where industry like 'crypto%';

-- US has a dot trailing in one of the entries
select distinct country
from layoffs_staging2
order by 1;

Update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

-- Change the date from string to date format
select `date`
from layoffs_staging2;

update layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` DATE;

select *
from layoffs_staging2;

-- Step 3 : Work with Null and Blank Values

Select *
from layoffs_staging2
where total_laid_off is NULL
AND percentage_laid_off is NULL;

Select distinct Industry
from layoffs_staging2;

Select *
from layoffs_staging2
where industry is  null
or industry = '';

SELECT *
from layoffs_staging2
where company = 'Airbnb';

update layoffs_staging2
set industry = NULL
where industry = '';

select *
from layoffs_staging2 t1
join layoffs_staging2 t2
	on	t1.company = t2.company
where (t1.industry is NULL or t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
join layoffs_staging2 t2
	on	t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is NULL or t1.industry = '')
AND t2.industry IS NOT NULL;

SELECT *
from layoffs_staging2
where company like 'Bally%';

select *
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is Null;

Delete
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is Null;

-- Step 4
ALTER table layoffs_staging2
drop column row_num;