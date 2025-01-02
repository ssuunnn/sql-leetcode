SELECT P.product_name,
       SUM(O.unit) AS unit
  FROM Products P
  JOIN (SELECT *
          FROM Orders
         WHERE MONTH(order_date) = 2
           AND YEAR(order_date) = 2020) O
    ON P.product_id = O.product_id
 GROUP BY P.product_id
HAVING SUM(O.unit) >= 100;