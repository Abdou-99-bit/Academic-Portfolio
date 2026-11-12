SELECT g.name_genre
FROM genre AS g
LEFT JOIN book AS b ON g.genre_id = b.genre_id
WHERE b.genre_id IS NULL;
