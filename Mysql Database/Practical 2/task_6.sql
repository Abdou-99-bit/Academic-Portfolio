SELECT 
    ROUND(AVG(price), 2) AS Average_price,
    ROUND(SUM(price * amount), 2) AS Cost
FROM book
WHERE amount BETWEEN 5 AND 14;







