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

SELECT
	"date",
	"pricePerGallonGas",
	"price_per_kwh",
	"DATE"
FROM
	electricity_price
LEFT JOIN gas_price ON "DATE" = "date"

--EDITING altfuel_stations TABLE
SELECT * FROM altfuel_stations

--Removing bad data based on fuel type code
SELECT
	"Fuel_Type_Code",
	"State"
FROM
	altfuel_stations
WHERE
	"Fuel_Type_Code" <> 'ELEC';
	
DELETE FROM altfuel_stations
WHERE "Fuel_Type_Code" <> 'ELEC'
RETURNING *;

--Checking for additional bad data based on State
SELECT
	"Fuel_Type_Code",
	"State"
FROM
	altfuel_stations
WHERE
	LENGTH("State") <> 2;

--Fixing data type for latitude
alter table altfuel_stations 
   alter column "Latitude" type decimal(25,20) using "Latitude"::decimal;
   
--Fixing data type for Longitude
alter table altfuel_stations 
   alter column "Longitude" type decimal(25,20) using "Longitude"::decimal;

--Removing null ID values with no longitude and latitude coordinates
SELECT
	"Station_Name",
	"ID",
	"Longitude",
	"Latitude"
	
FROM
	altfuel_stations
WHERE
	"ID" IS Null;
	
DELETE FROM altfuel_stations
WHERE "ID" IS Null
RETURNING *;

SELECT * FROM brands

--Replacing Null with zero in tanksize
UPDATE brands SET tanksize = 0 WHERE tanksize IS NULL;
SELECT * FROM brands
ORDER BY
	modelid ASC;

--Correcting datatypes in county_income
SELECT * FROM city_income;

--Remove commas
update city_income
       set "2019" = regexp_replace("2019", ',','','g');
update city_income
       set "2018" = regexp_replace("2018", ',','','g');
update city_income
       set "2020" = regexp_replace("2020", ',','','g');	   
	   
--Set to integars
ALTER TABLE city_income
ALTER COLUMN "2020" TYPE INT USING "2020"::integer;
ALTER TABLE city_income
ALTER COLUMN "2019" TYPE INT USING "2019"::integer;
ALTER TABLE city_income
ALTER COLUMN "2018" TYPE INT USING "2018"::integer;

--Standardize all dates to first of month when it is not an event date
SELECT * FROM monthly_sales;

ALTER TABLE monthly_sales ALTER COLUMN "date_value" TYPE DATE 
using to_date("date_value", 'YYYY-MM');
ALTER TABLE electic_vehicle_daily_count ALTER COLUMN "Date" TYPE DATE 
using to_date("Date", 'YYYY-MM');