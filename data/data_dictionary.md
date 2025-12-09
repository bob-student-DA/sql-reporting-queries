# Data Dictionary

This project uses a small, business-style sales dataset designed for practicing SQL joins, filters, aggregations, and recurring reporting.

## Overview of Tables
- **customers**: customer account information
- **products**: product catalog and pricing
- **orders**: order header details (dates, status, shipping targets/actuals)
- **order_items**: line items that connect orders to products and quantities

---

## Table: customers
**Grain:** 1 row per customer

| Column | Type | Description | Example |
|---|---|---|---|
| customer_id | INTEGER (PK) | Unique ID for each customer | 1 |
| customer_name | TEXT | Customer name | Silver Rock Supply |
| state | TEXT | Customer state/region code | NV |
| created_at | DATE | Date customer was created/added | 2024-01-15 |

**Notes**
- `customer_id` is the primary key.
- `state` is optional in this sample dataset, but typically present in real data.

---

## Table: products
**Grain:** 1 row per product

| Column | Type | Description | Example |
|---|---|---|---|
| product_id | INTEGER (PK) | Unique product identifier | 10 |
| product_name | TEXT | Name of the product | Widget A |
| category | TEXT | Product category | Widgets |
| unit_price | NUMERIC(10,2) | Price per unit | 12.50 |

**Notes**
- `unit_price` is stored at the product level (assumes stable pricing in this toy dataset).

---

## Table: orders
**Grain:** 1 row per order (order header)

| Column | Type | Description | Example |
|---|---|---|---|
| order_id | INTEGER (PK) | Unique order identifier | 100 |
| customer_id | INTEGER (FK → customers.customer_id) | Customer placing the order | 1 |
| order_date | DATE | Date order was placed | 2024-04-01 |
| target_ship_date | DATE | Promised/target ship date | 2024-04-03 |
| actual_ship_date | DATE | Actual ship date (NULL if not shipped) | 2024-04-02 |
| status | TEXT | Current order status | Shipped |

**Notes**
- `actual_ship_date` can be NULL for orders not shipped yet.
- Late shipment logic typically: `actual_ship_date > target_ship_date` (when both are not NULL).

---

## Table: order_items
**Grain:** 1 row per product line item on an order

| Column | Type | Description | Example |
|---|---|---|---|
| order_item_id | INTEGER (PK) | Unique line item identifier | 1000 |
| order_id | INTEGER (FK → orders.order_id) | The order this line belongs to | 100 |
| product_id | INTEGER (FK → products.product_id) | The product on the line | 10 |
| quantity | INTEGER | Units ordered for the product | 2 |

**Notes**
- Revenue is calculated as: `quantity * unit_price` (joined from `products`).
- Order totals are calculated by summing line revenue per `order_id`.

---

## Common Joins
- `orders.customer_id = customers.customer_id`
- `order_items.order_id = orders.order_id`
- `order_items.product_id = products.product_id`

## Common Metrics
- **Line revenue:** `order_items.quantity * products.unit_price`
- **Order revenue:** sum(line revenue) grouped by `orders.order_id`
- **Customer revenue:** sum(line revenue) grouped by `customers.customer_id` (or name)
- **Delayed shipment:** `actual_ship_date > target_ship_date` (excluding NULLs)
