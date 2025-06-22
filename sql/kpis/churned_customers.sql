SELECT COUNT(*) AS churned_customers
FROM (
  SELECT customer_name, MAX(delivery_date) AS last_order
  FROM order_table
  WHERE item IN ('Loca Loka Blanco', 'Loca Loka Reposado')
  [[ AND {{item}} ]]
  [[ AND 
    CASE 
      WHEN {{ironhill_toggle}} = 'Only Ironhill' THEN customer_name = 'Ironhill Hospitality Pte Ltd'
      ELSE TRUE
    END
  ]]
  [[ AND {{delivery_date}} ]]
  [[ AND {{customer_category}} ]]
  [[ AND {{fulfillment_warehouse}} ]]
  [[ AND {{category}} ]]
  [[ AND {{product_group}} ]]
  GROUP BY customer_name
  HAVING last_order < DATE_SUB(CURDATE(), INTERVAL 60 DAY)
) AS churned;