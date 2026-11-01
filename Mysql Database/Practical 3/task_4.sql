SELECT 
    author,
    title,
    price
FROM book
WHERE price < (
    SELECT MAX(min_price)
    FROM (
        SELECT MIN(price) AS min_price
        FROM book
        GROUP BY author
    ) AS t
);
