CREATE DATABASE coffee_shop_db;

SELECT * FROM coffee_shop_sales;

DESCRIBE coffee_shop_sales;

SET SQL_SAFE_UPDATES = 0;

UPDATE coffee_shop_sales SET transaction_date = STR_TO_DATE(transaction_date, '%d-%m-%Y');

ALTER TABLE coffee_shop_sales MODIFY COLUMN transaction_date DATE;

UPDATE coffee_shop_sales SET transaction_time = STR_TO_DATE(transaction_time, '%H:%i:%s');

ALTER TABLE coffee_shop_sales MODIFY COLUMN transaction_time TIME;

ALTER TABLE coffee_shop_sales CHANGE COLUMN ï»¿transaction_id transaction_id INT;