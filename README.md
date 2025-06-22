# Ironhill SKU Dashboard (Metabase)

This repository contains SQL logic, variable configuration, and setup documentation for the Ironhill SKU depletion dashboard on Metabase.

## 🔍 Purpose

Track depletion metrics and customer engagement for two key SKUs:
- `Loca Loka Blanco`
- `Loca Loka Reposado`

## 🧩 Filters

All SQL logic supports the following dynamic Metabase filters:
- `{{item}}`: Text input filter scoped to the two items only
- `{{ironhill_toggle}}`: Dropdown with `All`, `Only Ironhill`
- `{{delivery_date}}`: Date range
- `{{customer_category}}`: Optional customer type segmentation

## ⚙️ Deployment Notes

All queries are optimized for `order_table` and assume:
```sql
item IN ('Loca Loka Blanco', 'Loca Loka Reposado')
```
is hardcoded before the optional filters are applied.

## 📊 KPI Logic

SQL in `sql/kpis/` defines the logic for metrics:
- Orders
- Customers
- Repeat Buyers
- Churned Customers

## 📈 Visuals

SQL in `sql/visuals/` powers bar charts, donut charts, and top-N tables.

## 🧠 Advanced Logic

See `sql/advanced/customer_volume_buckets.sql` for a rewritten version of the DAX formula from Power BI into SQL for Metabase.

## 🚨 Debugging History

See `jira/ironhill_debugging_update.md` for a full retrospective of integration issues and their resolutions.
