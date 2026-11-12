SELECT 
    g.name_genre AS genre,
    b.title AS book,
    a.name_author AS author
FROM book AS b
JOIN genre AS g ON b.genre_id = g.genre_id
JOIN author AS a ON b.author_id = a.author_id
WHERE g.name_genre LIKE '%Роман%'
ORDER BY b.title ASC;
