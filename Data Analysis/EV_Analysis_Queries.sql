--Total number of EV sales per month from 2011 to 2019
SELECT date_value, SUM(monthly_sales)
INTO total_monthly_sales
FROM monthly_sales GROUP BY (date_value)
ORDER BY date_value ASC
SELECT * FROM total_monthly_sales;

--Correcting datatypes in county_income
SELECT * FROM county_income;

update county_income
       set year_2019 = regexp_replace(year_2019, ',','','g');
update county_income
       set year_2018 = regexp_replace(year_2018, ',','','g');

ALTER TABLE county_income
ALTER COLUMN year_2020 TYPE INT USING year_2020::integer;
ALTER TABLE county_income
ALTER COLUMN year_2019 TYPE INT USING year_2019::integer;
ALTER TABLE county_income
ALTER COLUMN year_2018 TYPE INT USING year_2018::integer;

SELECT * FROM county_income
WHERE LENGTH(fips) >5;

UPDATE county_income
	set fips = fipsc WHERE LENGTH(fips) >5;

