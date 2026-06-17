**Commercial & Hospitality Data Analytics**

### Project Overview
This repository contains production-ready SQL scripts designed to analyze customer behavior, optimize pricing structures, and track financial performance.

The case study is based on analytical objectives achieved for a hospitality business (Family Recreation Club "Podsnezhnik"), aiming to:
1. Conduct **Cohort Analysis** to track user retention and evaluate the impact of shifting from third-party travel agencies (OTA) to high-margin direct bookings.
2. Analyze **Revenue Structure & Profitability (EBITDA)** across different operational categories to isolate low-season demand drivers.

### Repository Structure
* `scripts/cohort_retention_analysis.sql` — Main query containing advanced analytical metrics (CTEs, window functions, and date-truncation tools).

### Tech Stack & Key Concepts Covered
* **Dialect:** PostgreSQL
* **Techniques:** Common Table Expressions (CTEs), Window Functions, Multi-level Aggregations, Date/Time Manipulation.

### Expected Analytical Output

When executed against the production database, the script generates a multi-dimensional retention matrix:

| cohort | base_users | cohort_index | active_users | retention_rate_pct | total_bookings_volume | total_revenue | arpu | direct_revenue_share_pct |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 2026-01-01 | 120 | 0 | 120 | 100.00 | 145 | 450000 | 3750.00 | 65.20 |
| 2026-01-01 | 120 | 1 | 42 | 35.00 | 58 | 185000 | 4404.76 | 72.10 |
| 2026-01-01 | 120 | 2 | 30 | 25.00 | 36 | 120000 | 4000.00 | 81.50 |
| 2026-02-01 | 95 | 0 | 95 | 100.00 | 102 | 310000 | 3263.15 | 68.00 |
| 2026-02-01 | 95 | 1 | 28 | 29.47 | 34 | 105000 | 3750.00 | 78.40 |

### Key Business Insights Evident from the Data:
1. **LTV Growth:** Even though the number of active users drops over time (Retention Rate), the *Average Revenue Per Active User (ARPU)* increases in Month 1 and Month 2, showing deeper customer engagement.
2. **Channel Shift Optimization:** The `direct_revenue_share_pct` consistently grows in older cohorts, validating our marketing strategy to shift customers away from expensive OTA platforms to direct booking channels.

### How to Run & Test Locally

You can test this SQL pipeline in 2 simple steps using any online PostgreSQL compiler (like [DB-Fiddle](https://www.db-fiddle.com/) or [SQL Fiddle](https://sqlfiddle.com/)):
1. Copy and execute the contents of `scripts/sample_database.sql` to build the schema and populate mock data.
2. Run the main analytical query from `scripts/cohort_retention_analysis.sql` to get the final cohort matrix.