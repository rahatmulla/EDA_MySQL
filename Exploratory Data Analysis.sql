-- Exploratory Data Analysis

select *
from layoffs_staging2;

select company, total_laid_off, percentage_laid_off
from layoffs_staging2
order by total_laid_off DESC
LIMIT 3;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions DESC;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 DESC
LIMIT 3;

SELECT COMPANY, total_laid_off
from layoffs_staging2
order by 2 desc
limit 5;

select min(date), max(date)
from layoffs_staging2;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 DESC;

select YEAR(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`);

select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 1 DESC;

select SUBSTRING(`date`,1,7) AS MONTH, sum(total_laid_off)
from layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
group by MONTH
order by 1 ASC;

select 

SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC;

WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
where SUBSTRING(date,1,7) is not Null
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;


select SUBSTRING(date,1,4) AS YEAR, sum(total_laid_off) as total_off
from layoffs_staging2
group by YEAR
order by YEAR;

WITH ROLLING_TOTAL AS (
    SELECT 
        SUBSTRING(date, 1, 4) AS YEAR,
        SUM(total_laid_off) AS TOTAL_OFF
    FROM layoffs_staging2
    WHERE SUBSTRING(date, 1, 4) IS NOT NULL   
    GROUP BY YEAR
    ORDER BY YEAR
)
SELECT YEAR, SUM(TOTAL_OFF) OVER (ORDER BY YEAR) AS rolling_total
FROM ROLLING_TOTAL;

select company, total_laid_off
from layoffs_staging2
where percentage_laid_off = '1'
order by total_laid_off DESC
LIMIT 3;

select stage, percentage_laid_off
from layoffs_staging2
where stage = 'Series D' or stage = 'Post-IPO';

WITH industry_layoffs AS (
    SELECT 
        industry,
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging2
    GROUP BY industry
)
SELECT *
FROM industry_layoffs
ORDER BY total_laid_off DESC;

SELECT country, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC
LIMIT 5;
