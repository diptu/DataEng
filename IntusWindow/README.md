# Refactoring the SQL Query into dbt Models

We'll break down the original query into smaller, more manageable dbt models.

- **stg_sales_transactions.sql**
  - This model will simply select and clean the sales transactions data.
- **stg_marketing_events.sql**
This model will select and clean the marketing events data.