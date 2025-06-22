# Debugging Summary: Ironhill Dashboard

## Problem:
Metabase failed to allow a dual-condition filter: hardcoded item set + optional item dropdown.

## Attempted Solutions:
- Field filter via dashboard and SQL linking → failed
- Text + CASE logic for toggle → failed
- New filtered table (`ironhill_orders`) → no effect

## Final Working Solution:
- Hardcoded `item IN (...)` clause
- `{{item}}` as text filter dropdown (manually limited to 2 SKUs)
- Optional override for dashboard viewers

This method was tested successfully and works for all KPIs and visuals.
