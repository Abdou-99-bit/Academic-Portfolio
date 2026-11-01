SELECT 
    author AS Author,
    COUNT(DISTINCT title) AS Distinct_books,
    SUM(amount) AS Number_of_copies
FROM book
GROUP BY author;

