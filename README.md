# SQL Reporting Queries (Practice)

A small SQL practice project demonstrating how to answer common business questions and support recurring reporting using joins, filters, and aggregations.

## Skills Demonstrated
- JOINs (INNER, LEFT)
- Filtering (WHERE, IN, BETWEEN, LIKE, NULL handling)
- Aggregations (COUNT, SUM, AVG, GROUP BY, HAVING)
- Reporting patterns (monthly rollups, operational metrics)
- Basic data quality checks

## Repository Structure
- `data/` — schema + sample seed data + data dictionary
- `queries/` — SQL scripts grouped by topic
- `answers/` — brief notes on what each query answers / expected output

## How to Run (SQLite)
```bash
# from repo root
sqlite3 practice.db < data/schema.sql
sqlite3 practice.db < data/seed.sql

# run a query file (example)
sqlite3 practice.db < queries/01_joins.sql


# sql-reporting-queries # SQL Practice — Business Questions & Recurring Reporting

This repository contains SQL practice exercises focused on writing practical queries to answer business questions and support recurring reporting.

## Skills Demonstrated
- Joins (INNER, LEFT)
- Filtering (WHERE, BETWEEN, IN, LIKE)
- Aggregations (COUNT, SUM, AVG, GROUP BY, HAVING)
- Basic reporting patterns (weekly/monthly rollups)
- Light data quality checks (nulls, duplicates)

## How to Use
1. Create the sample schema and seed data:
   - Run `data/schema.sql`
   - Run `data/seed.sql`
2. Explore queries in `/queries`:
   - Each file contains multiple questions and SQL solutions.
3. Notes and expected outputs are in `/answers`.

## Example Questions Covered
- Which customers generate the most revenue?
- What are the month-over-month sales trends?
- Which products have declining sales?
- How many orders are delayed beyond the target ship date?
