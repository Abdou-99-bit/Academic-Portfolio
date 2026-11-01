SELECT 
    b.title,
    g.name_genre AS genre,
    b.price
FROM book AS b
JOIN genre AS g ON b.genre_id = g.genre_id
WHERE b.amount > 8
ORDER BY b.price DESC;
