--Total number of EV sales per month from 2011 to 2019
SELECT date_value, SUM(monthly_sales)
INTO total_monthly_sales
FROM monthly_sales GROUP BY (date_value)
ORDER BY date_value ASC
SELECT * FROM total_monthly_sales;

--Creating join for gas and elctricity price comparison
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

--Editing brands table
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

--Updating open date and adding open month in altfuel_stations
SELECT * FROM altfuel_stations;

ALTER TABLE altfuel_stations 
ADD COLUMN "Date";

UPDATE altfuel_stations SET "Open_Date" = "Date";

ALTER TABLE altfuel_stations ALTER COLUMN "Date" TYPE DATE 
using to_date("Date"::text, 'YYYY-MM');

--Creating ML table
create table MacLea as 
SELECT total_monthly_sales.month, total_monthly_sales.sum AS total_EV, 
   electricity_price.price_per_kwh AS elec_price, gas_price.price AS gas_price, 
   q1.count AS model_id_count,q3.count AS brand_id_count,q4.sum AS EV_stations,
   M1.sum AS ElecV_Totals,M2.sum AS Hybrid_Totals
FROM total_monthly_sales
--Join to add electricity price
LEFT JOIN electricity_price
ON total_monthly_sales.month = electricity_price.month
--Join to add gas price
LEFT JOIN gas_price
ON total_monthly_sales.month = gas_price.month
--Join to count number of models sold that month
LEFT JOIN(SELECT month, COUNT(model_id)
   	FROM monthly_sales 
	WHERE monthly_sales <> 0
	GROUP BY (month))as q1
ON total_monthly_sales.month = q1.month
--Join to count number of unique manfuacturers sold that month
LEFT JOIN(SELECT month, COUNT(distinct(brandid))
   	FROM (SELECT monthly_sales.month, monthly_sales.model_id, 
	   		monthly_sales.monthly_sales,brands.brandid
			FROM monthly_sales
			LEFT JOIN brands
			ON monthly_sales.model_id = brands.modelid) AS q2
	WHERE monthly_sales <> 0
	GROUP BY (month))q3
ON total_monthly_sales.month = q3.month
--Join to add running total of EV charging stations available that month
LEFT JOIN(SELECT month, sum(count(month)) OVER (ORDER BY month)
   	FROM altfuel_stations 
	GROUP BY (month))as q4
ON total_monthly_sales.month = q4.month
--Join to add total sales of subtype elkectric vehicles
LEFT JOIN (SELECT SUM(monthly_sales.monthly_sales), monthly_sales.month
	FROM monthly_sales
	JOIN brands
  	ON monthly_sales.model_id = brands.modelid
    WHERE brands.evtype = 'ev'
    GROUP BY monthly_sales.month) AS M1
ON total_monthly_sales.month = M1.month
--Join to add total sales of subtype hybrid vehicles
LEFT JOIN (SELECT SUM(monthly_sales.monthly_sales), monthly_sales.month
	FROM monthly_sales
	JOIN brands
  	ON monthly_sales.model_id = brands.modelid
    WHERE brands.evtype = 'hybrid'
    GROUP BY monthly_sales.month) AS M2
ON total_monthly_sales.month = M2.month
ORDER BY month ASC;

SELECT * FROM maclea;
UPDATE maclea SET model_id_count = 0, brand_id_count = 0
WHERE total_EV = 0

--drop row with no total sales--
DELETE FROM maclea
WHERE total_ev = 0;

