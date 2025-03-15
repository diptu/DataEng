# Refactoring the SQL Query into dbt Models

We'll break down the original query into smaller, more manageable dbt models.

- **stg_sales_transactions**
  - This model will simply select and clean the sales transactions data.
- **stg_marketing_events**
  - This model will select and clean the marketing events data.
  - **materialized**: *incremental*: Sets the model to be materialized incrementally.
  - *unique_key: event_id:* Specifies the unique key used for incremental processing
- **dim_product_catalog**
  - This model will select the product catalog data
- **daily_marketing_costs**
  - This model will pre-aggregate the marketing costs by year,month and day
- **fct_daily_sales_summary**
 - This model will join the sales, product, and marketing data, and calculate the final metrics.

# Dbt Macro
 - *extract_year_month_day* has been created as a macro to inside dbt models.

# Generic Test

## `is_positive` Test

This generic test checks if a specified numeric column in a model contains only positive values (values greater than 0).

**Purpose:**

The `is_positive` test is used to ensure data quality by verifying that a column, which is expected to hold positive numbers, does not contain any zero or negative values. This is useful for columns representing metrics like revenue, counts, or other quantities that should naturally be positive.

## dbt Documentation Generation and Serving

This document outlines the steps to generate and view dbt project documentation using the `dbt docs` command-line interface.

  **Generate dbt Documentation:**

    * In your terminal, run the following command:

    ```bash
    cd task
    dbt docs generate
    ```

 **Serve dbt Documentation:**

    * After the documentation generation is complete, run the following command:

    ```bash
    dbt docs serve
    ```