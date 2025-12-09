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
