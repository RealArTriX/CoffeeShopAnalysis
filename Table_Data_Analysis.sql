SELECT * FROM coffee_shop_sales;

SELECT CONCAT(ROUND(SUM(unit_price * transaction_qty))/1000, 'K') AS Total_Sales 
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 3;

SELECT 
	MONTH(transaction_date) AS MONTH,
	ROUND(SUM(unit_price *  transaction_qty)) AS Total_sales,
	(SUM(unit_price *  transaction_qty) - LAG(SUM(unit_price *  transaction_qty), 1)
	OVER(ORDER BY MONTH(transaction_date))) / LAG(SUM(unit_price *  transaction_qty), 1)
    OVER(ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM coffee_shop_sales 
WHERE MONTH(transaction_date) IN (4, 5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

SELECT COUNT(transaction_id) AS Total_orders
FROM coffee_shop_sales 
WHERE MONTH(transaction_date) = 5;

SELECT 
	MONTH(transaction_date) AS MONTH,
	ROUND(COUNT(transaction_id)) AS Total_orders,
	(COUNT(transaction_id) - LAG(COUNT(transaction_id), 1)
	OVER(ORDER BY MONTH(transaction_date))) / LAG(COUNT(transaction_id), 1)
    OVER(ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM coffee_shop_sales 
WHERE MONTH(transaction_date) IN (4, 5)
GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

SELECT SUM(transaction_qty) AS Total_quantity
FROM coffee_shop_sales 
WHERE MONTH(transaction_date) = 5;

SELECT 
	MONTH(transaction_date) AS MONTH,
	ROUND(SUM(transaction_qty)) AS Total_orders,
	(SUM(transaction_qty) - LAG(SUM(transaction_qty), 1)
	OVER(ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty), 1)
    OVER(ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM coffee_shop_sales 
WHERE MONTH(transaction_date) IN (4, 5)

GROUP BY MONTH(transaction_date)
ORDER BY MONTH(transaction_date);

SELECT
	CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000, 1), 'K') AS Total_sales,
    CONCAT(ROUND(SUM(transaction_qty)/1000, 1), 'K') AS Total_qty_sold,
    CONCAT(ROUND(COUNT(transaction_id)/1000, 1), 'K') AS total_orders
FROM coffee_shop_sales
WHERE transaction_date = '2023-05-18';

SELECT
	CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekends'
    ELSE 'Weekdays'
    END AS day_type,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000, 1), 'K') AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 2
GROUP BY
	CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekends'
    ELSE 'Weekdays'
    END;
    
SELECT
	store_location,
	CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000, 2), 'K') AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6
GROUP BY store_location
ORDER BY SUM(unit_price * transaction_qty) DESC;

SELECT
	CONCAT(ROUND(AVG(total_sales)/1000, 1), 'K') AS Avg_sales
FROM
	(
	SELECT SUM(unit_price *transaction_qty) AS total_sales
	FROM coffee_shop_sales
	WHERE MONTH(transaction_date) = 4
	GROUP BY transaction_date
	) AS Inner_query;
    
    SELECT
		DAY(transaction_date) AS Day_of_month,
        ROUND(SUM(unit_price * transaction_qty), 1) AS Total_Sales
	FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 5
    GROUP BY DAY(transaction_date)
    ORDER BY DAY(transaction_date);
    
SELECT 
    day_of_month,
    CASE 
        WHEN total_sales > avg_sales THEN 'Above Average'
        WHEN total_sales < avg_sales THEN 'Below Average'
        ELSE 'Average'
    END AS sales_status,
    total_sales
FROM (
    SELECT 
        DAY(transaction_date) AS day_of_month,
        SUM(unit_price * transaction_qty) AS total_sales,
        AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
    FROM 
        coffee_shop_sales
    WHERE 
        MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
        DAY(transaction_date)
) AS sales_data
ORDER BY 
    day_of_month;

SELECT
	product_category,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000, 1), 'K') AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_category
ORDER BY SUM(unit_price * transaction_qty) DESC;

SELECT
	product_type,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000, 1), 'K') AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5 AND product_type = 'Coffee'
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) DESC
LIMIT 10;

SELECT
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000, 1), 'K') AS Total_sales,
    SUM(transaction_qty) AS Total_qty_Sold,
    COUNT(*) AS Total_orders
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
AND DAYOFWEEK(transaction_date) = 1
AND HOUR(transaction_time) = 14;

SELECT
	HOUR(transaction_time),
	CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000, 1), 'K') AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY HOUR(transaction_time)
ORDER BY HOUR(transaction_time);

SELECT
	CASE
		WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
	END AS Day_of_week,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000, 1), 'K') AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY
	CASE
		WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
	END ;
    