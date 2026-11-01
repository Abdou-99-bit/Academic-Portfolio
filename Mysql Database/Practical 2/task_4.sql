SELECT 
    author AS Author,
    ROUND(SUM(price * amount), 2) AS Cost,
    ROUND((SUM(price * amount) * 18 / 100) / (1 + 18 / 100), 2) AS VAT,
    ROUND(SUM(price * amount) / (1 + 18 / 100), 2) AS Cost_without_VAT
FROM book
GROUP BY author;
