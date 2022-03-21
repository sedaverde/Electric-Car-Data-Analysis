--Total number of EV sales per month from 2011 to 2019
SELECT date_value, SUM(monthly_sales)
INTO total_monthly_sales
FROM monthly_sales GROUP BY (date_value)
ORDER BY date_value ASC
SELECT * FROM total_monthly_sales;

