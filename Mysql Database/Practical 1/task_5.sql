SELECT title, author, amount, 
ROUND(price, 0.3) AS new_prices
FROM book;
