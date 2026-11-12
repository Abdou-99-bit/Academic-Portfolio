SELECT 
    a.name_author AS author,
    COUNT(b.book_id) AS `Количество`
FROM 
    author a
LEFT JOIN 
    book b ON a.author_id = b.author_id
GROUP BY 
    a.author_id, a.name_author
HAVING 
    COUNT(b.book_id) < 10
ORDER BY 
    `Количество` ASC;
