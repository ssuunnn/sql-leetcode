SELECT
    D.name AS Department,
    E.name AS Employee,
    salary AS Salary
FROM (
    SELECT
        *,
        DENSE_RANK() OVER(
            PARTITION BY departmentId
            ORDER BY salary DESC) AS r
    FROM
        Employee
) E
JOIN Department D
    ON E.departmentId = D.id
WHERE r <= 3;