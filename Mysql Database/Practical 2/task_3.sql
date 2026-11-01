SELECT
    author AS Author,
    MIN(price) AS Minimum_price,
    MAX(price) AS Maximum_price,
    AVG(price) AS Average_price
FROM book
GROUP BY author;
