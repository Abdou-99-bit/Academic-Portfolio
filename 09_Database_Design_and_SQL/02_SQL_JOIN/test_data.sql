SET SESSION cte_max_recursion_depth = 2000000;
INSERT INTO test_data (name, email, created_at, value, is_active)
WITH RECURSIVE cte (n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM cte WHERE n < 2000000
    )
    SELECT 
    CONCAT('User_', n),
    CONCAT('user_', n, '@example.com'),
    NOW() - INTERVAL FLOOR(RAND() * 365) DAY,
    FLOOR(RAND() * 1000),
    RAND() > 0.5
FROM cte;
