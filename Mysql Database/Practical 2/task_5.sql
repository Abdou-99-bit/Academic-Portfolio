SELECT 
    MIN(price) AS Minimum_price,
    MAX(price) AS Maximum_price,
    ROUND(AVG(price), 2) AS Average_price
FROM book;
