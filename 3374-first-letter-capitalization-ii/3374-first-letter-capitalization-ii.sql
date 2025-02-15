WITH RECURSIVE iter (pos) AS (
    SELECT 1
    UNION ALL
    SELECT
        i.pos + 1
    FROM
        iter i
    WHERE
        i.pos + 1 <= (SELECT MAX(LENGTH(content_text)) FROM user_content)
),
t AS (
    SELECT
        *,
        SUBSTR(content_text, pos, 1) AS token,
        LAG(SUBSTR(content_text, pos, 1))
            OVER(PARTITION BY content_id ORDER BY pos) AS previous_token
    FROM
        user_content
    CROSS JOIN
        iter
)
SELECT
    content_id,
    content_text AS original_text,
    GROUP_CONCAT(CASE
        WHEN previous_token IS NULL OR previous_token IN (' ', '-')
            THEN UPPER(token)
            ELSE LOWER(token)
        END ORDER BY pos SEPARATOR '') AS converted_text
FROM
    t
GROUP BY
    content_id, content_text;