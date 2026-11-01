SELECT 
    c.name_city AS city,
    a.name_author AS author,
    DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 365) DAY) AS `Date`
FROM 
    city c
CROSS JOIN 
    author a
ORDER BY 
    c.name_city ASC,
    `Date` DESC;
