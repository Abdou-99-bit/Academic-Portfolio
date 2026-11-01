SELECT 
    author,
    ROUND(SUM(price * amount), 2) AS Cost
FROM book
WHERE title NOT IN ('Идиот', 'Белая гвардия')
GROUP BY author
HAVING SUM(price * amount) > 5000
ORDER BY Cost DESC;
