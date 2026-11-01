UPDATE book
SET buy = CASE
    WHEN buy > amount THEN amount
    ELSE buy
END;
UPDATE book
SET price = ROUND(price * 0.9, 2)
WHERE buy = 0;


SELECT * FROM book;-- 