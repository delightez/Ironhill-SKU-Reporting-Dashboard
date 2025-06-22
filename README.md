# 🧾 Ironhill Dashboard Migration Project – Full Summary

## 📌 Project Objective

To migrate three Power BI dashboards into **Metabase**, with production-ready SQL logic, filters, and dashboard views, tailored for **Loca Loka Reposado** and **Loca Loka Blanco** depletion tracking across Ironhill and other customers.

---

## 🚚 Migration Scope

We successfully migrated:

### ✅ Dashboards:
1. **Sales Dashboard**
2. **Ironhill SKU Dashboard**
3. **Customer Segmentation Dashboard**

Each Metabase dashboard:
- Uses production MySQL data from `order_table`
- Is scoped to `item IN ('Loca Loka Blanco', 'Loca Loka Reposado')`
- Includes filters to allow drilldown on delivery date, customer category, and more

---

## 🧠 Technical Stack

| Component         | Stack Used                  |
|------------------|-----------------------------|
| Backend Database | MySQL                       |
| Visualization    | Metabase                    |
| App Layer        | Laravel 11 (for embedding)  |
| Filters          | Metabase native SQL + UI    |

---

## 🔧 Metabase Filters Implemented

| Filter Name         | Description                                               |
|---------------------|-----------------------------------------------------------|
| `item`              | Dropdown scoped to 2 SKUs: Blanco & Reposado             |
| `ironhill_toggle`   | Toggle: `All` vs `Only Ironhill Hospitality Pte Ltd`     |
| `delivery_date`     | Date filter using `delivery_date` column                 |
| `customer_category` | Optional segmentation                                    |
| `fulfillment_warehouse`, `category`, `product_group` | Optional for advanced filters |

---

## 📊 KPIs & Visuals

### Core KPIs:
- ✅ Total Orders
- ✅ Unique Customers
- ✅ Repeat Buyers
- ✅ Churned Customers

### Visuals:
- 📉 Monthly Depletion by Customer Category
- 📈 SKU Breakdown over Time
- 🧑‍💼 Top 10 Customers
- 📊 Depletion by Product

---

## 🧮 DAX-to-SQL Migration

We rewrote complex DAX formulas from Power BI, such as:

```dax
Customer Volume Buckets = 
  AVG(Sales Qty / Months)
  Categorized into buckets: <=6, 7–12, ..., >24
```

✅ Rewritten in MySQL using:
- `PERIOD_DIFF()` to compute months
- `CASE WHEN` to map average volume to categories
- Metabase-compatible filter blocks

---

## 🛠️ Challenges & Debugging Summary

| Challenge                         | What We Tried                                | Outcome |
|----------------------------------|-----------------------------------------------|---------|
| `item` filter conflict with hardcoded clause | Field Filter, Text Filter, Views             | ❌ Failed |
| Metabase widget not appearing    | Native query config, variable names checked  | ❌ Failed |
| New table: `ironhill_orders`     | Created filtered table                       | ❌ No effect |
| ✅ Final Fix                     | Use hardcoded `item IN (...)` + optional `{{item}}` filter | ✅ Success |

Details are logged in `jira/ironhill_debugging_update.md`.

---

## 🪄 Automation Prep (Optional)

We’ve set this up so that in future:
- You can **push this to GitHub**
- Embed Metabase dashboards in your Laravel frontend
- Add CI/CD workflows to track query version changes

---

## 📦 Deliverables

- ✅ `README.md` for documentation
- ✅ SQL files: `/sql/kpis`, `/sql/visuals`, `/sql/advanced`
- ✅ `.gitignore`, `LICENSE`
- ✅ Metabase filter docs
- ✅ Debugging summary for Jira updates
