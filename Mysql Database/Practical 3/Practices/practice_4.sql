INSERT INTO book (title, author, price, amount)
SELECT title, author, price, amount
FROM supply
WHERE author NOT IN (
    SELECT DISTINCT author FROM book
);
SELECT * FROM book;






