SELECT P.product_id,
       IFNULL(ROUND(SUM(P.price * US.units) / SUM(US.units), 2), 0) AS average_price
  FROM Prices P
  LEFT
  JOIN UnitsSold US
    ON (US.purchase_date BETWEEN P.start_date AND P.end_date)
       AND (P.product_id = US.product_id)
 GROUP BY P.product_id;