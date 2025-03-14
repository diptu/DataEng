/*
   This model will simply select and clean the sales transactions data.
   
    create a incremental  for stg_marketing_events table 

   
*/
{{ config(materialized='incremental',unique_key='event_id') }}
SELECT
    event_id,
    user_id,
    event_type,
    event_timestamp,
    channel,
    campaign,
    cost
FROM {{ source('dev', 'marketing_events') }}

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records arriving later on the same day as the last run of this model)
  where event_timestamp >= (select coalesce(max(event_timestamp), '2025-03-12') from {{ this }})

{% endif %}
