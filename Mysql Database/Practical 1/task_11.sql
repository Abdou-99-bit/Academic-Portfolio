SELECT 
    title,
    author
FROM book
WHERE 
    title LIKE '% %'              
    AND author LIKE '% С.%'       
ORDER BY title ASC;