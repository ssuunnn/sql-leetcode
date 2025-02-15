WITH rts AS (
    SELECT
        CASE
            WHEN people >= 100
                AND LEAD(people) OVER(ORDER BY visit_date) >= 100
                AND LEAD(people, 2) OVER(ORDER BY visit_date) >= 100
                THEN CONCAT(id, ',', id + 1, ',', id + 2)
                ELSE NULL
        END AS rows_to_show
    FROM
        Stadium
),
rts_2 (rows_to_show) AS (
    SELECT
        SUBSTRING_INDEX(rows_to_show, ',', 1)
    FROM
        rts
    UNION
    SELECT
        SUBSTRING_INDEX(SUBSTRING_INDEX(rows_to_show, ',', 2), ',', -1)
    FROM
        rts
    UNION
    SELECT
        SUBSTRING_INDEX(SUBSTRING_INDEX(rows_to_show, ',', 3), ',', -1)
    FROM
        rts
)
SELECT *
FROM
    Stadium
WHERE
    id IN (SELECT rows_to_show FROM rts_2);