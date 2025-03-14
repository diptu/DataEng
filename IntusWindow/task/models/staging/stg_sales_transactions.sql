/*
   This model will simply select and clean the sales transactions data.
   
    create a view for stg_sales_transactions table 

*/

{{ config(materialized='incremental',unique_key='transaction_id') }}
SELECT
    transaction_id,
    product_id,
    user_id,
    transaction_timestamp,
    revenue,
    cost
    FROM {{ source('dev', 'sales_transactions') }}

    {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records arriving later on the same day as the last run of this model)
  where transaction_timestamp >= (select coalesce(max(transaction_timestamp), '2025-03-12') from {{ this }})

{% endif %}