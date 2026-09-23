-- SQL DATA CLEANING PROJECT

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT INTO layoffs_staging
SELECT *
FROM layoffs;

SELECT * 
FROM layoffs_staging;

with duplicate_cte as 
(
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location,
total_laid_off, `date`, industry,
funds_raised, country) AS row_num
FROM layoffs_staging
)
select *
from duplicate_cte
where  row_num > 1;

select *
from layoffs_staging 
where company = 'Cazoo';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `total_laid_off` text,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `source` text,
  `stage` text,
  `funds_raised` int DEFAULT NULL,
  `country` text,
  `date_added` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2;

insert into layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location,
total_laid_off, `date`, industry,
funds_raised, country) AS row_num
FROM layoffs_staging;

select *
from layoffs_staging2;

set SQL_SAFE_UPDATES = 0;

delete 
from layoffs_staging2
where row_num > 1;

SELECT *
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2
where company = 'Casper';

select trim(company)
from layoffs_staging2;

set SQL_SAFE_UPDATES = 0;

update layoffs_staging2
set company = trim(company);

select distinct industry
from layoffs_staging2
order by 1;

select distinct country
from layoffs_staging2
order by 1;

select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y');
update layoffs_staging2
set `date_added` = str_to_date(`date_added`,'%m/%d/%Y');
select *
from layoffs_staging2;

alter table layoffs_staging2
modify column `date_added` date;
select *
from layoffs_staging2;

select *
from layoffs_staging2
where industry is null or industry='';

select *
from layoffs_staging2
where company = 'Appsmith';

delete 
from layoffs_staging2
where (total_laid_off is null or total_laid_off ='')
and (percentage_laid_off is null or percentage_laid_off ='');

select *
from layoffs_staging2
where (total_laid_off is null or total_laid_off ='')
and (percentage_laid_off is null or percentage_laid_off ='');

select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;