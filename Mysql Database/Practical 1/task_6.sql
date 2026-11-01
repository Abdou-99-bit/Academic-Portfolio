SELECT 
    author,
    title,
    ROUND(
        CASE
            WHEN author = 'Mikhail Bulgakov' THEN price * 1.10
            WHEN author = 'Sergey Esenin' THEN price * 1.05
            ELSE price
        END, 
    2) AS new_price
FROM book;
