SELECT 
  DATE_FORMAT(delivery_date, '%Y-%m') AS month,
  item,
  SUM(sales_quantity) AS quantity
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
GROUP BY month, item
ORDER BY month;