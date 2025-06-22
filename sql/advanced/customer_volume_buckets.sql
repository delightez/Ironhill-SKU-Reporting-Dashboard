WITH monthly_span AS (
  SELECT
    PERIOD_DIFF(
      DATE_FORMAT(MAX(delivery_date), '%Y%m'),
      DATE_FORMAT('2024-12-01', '%Y%m')
    ) + 1 AS total_months
  FROM order_table
  WHERE item IN ('Loca Loka Blanco', 'Loca Loka Reposado')
  [[ AND {{item}} ]]
  [[ AND {{delivery_date}} ]]
  [[ AND {{ironhill_toggle}} = 'Only Ironhill' AND customer_name = 'Ironhill Hospitality Pte Ltd' ]]
  [[ AND {{customer_category}} ]]
  [[ AND {{fulfillment_warehouse}} ]]
  [[ AND {{category}} ]]
  [[ AND {{product_group}} ]]
),
customer_volumes AS (
  SELECT
    customer_name,
    SUM(sales_quantity) AS total_bottles
  FROM order_table
  WHERE item IN ('Loca Loka Blanco', 'Loca Loka Reposado')
  [[ AND {{item}} ]]
  [[ AND {{delivery_date}} ]]
  [[ AND {{ironhill_toggle}} = 'Only Ironhill' AND customer_name = 'Ironhill Hospitality Pte Ltd' ]]
  [[ AND {{customer_category}} ]]
  [[ AND {{fulfillment_warehouse}} ]]
  [[ AND {{category}} ]]
  [[ AND {{product_group}} ]]
  GROUP BY customer_name
),
buckets AS (
  SELECT
    cv.customer_name,
    ROUND(cv.total_bottles / ms.total_months, 2) AS avg_monthly_volume,
    CASE
      WHEN (cv.total_bottles / ms.total_months) <= 6 THEN '<=6'
      WHEN (cv.total_bottles / ms.total_months) <= 12 THEN '7-12'
      WHEN (cv.total_bottles / ms.total_months) <= 18 THEN '13-18'
      WHEN (cv.total_bottles / ms.total_months) <= 24 THEN '19-24'
      ELSE '>24'
    END AS volume_category
  FROM customer_volumes cv
  CROSS JOIN monthly_span ms
),
grouped AS (
  SELECT
    volume_category AS `Monthly Depletion`,
    COUNT(*) AS `# of Customer`
  FROM buckets
  GROUP BY volume_category
)
SELECT * FROM grouped
UNION ALL
SELECT 'Total', SUM(`# of Customer`)
FROM grouped;