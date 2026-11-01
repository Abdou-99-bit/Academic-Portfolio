SELECT
    title,
    author,
    amount,
    ( 
        (SELECT MAX(amount) FROM book) - amount
    ) AS `Order`
FROM book
WHERE amount < (SELECT MAX(amount) FROM book);
