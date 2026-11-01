UPDATE book
JOIN supply
  ON book.title = supply.title
  AND book.author = supply.author
SET 
  book.amount = book.amount + supply.amount,
  book.price = ROUND((book.price + supply.price) / 2, 2);

SELECT * FROM book;