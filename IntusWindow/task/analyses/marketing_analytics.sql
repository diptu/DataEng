/*
1.Cost per Acquisition (CPA)
Definition: Cost per Acquisition is calculated as the total cost of marketing events divided by the total number of acquisitions (sales).
2. Return on Marketing Investment (ROMI)
Definition: Return on Marketing Investment is calculated as the difference between total revenue from sales and total cost of marketing events, divided by the total cost of marketing events.
3. Event Conversion Rate
Definition: Event Conversion Rate is calculated as the number of sales transactions resulting from marketing events divided by the total number of marketing events, expressed as a percentage.

won't materialize in data warehouse
*/
{{ config(materialized='ephemeral') }}

WITH marketing_data AS (
    SELECT 
        SUM(me.cost) AS total_marketing_cost,
        COUNT(DISTINCT me.event_id) AS total_events,
        COUNT(DISTINCT st.user_id) AS total_acquisitions,
        SUM(st.revenue) AS total_revenue,
        COUNT(DISTINCT st.transaction_id) AS total_transactions
    FROM 
        {{ ref('stg_marketing_events') }} me
    LEFT JOIN 
        {{ ref('stg_sales_transactions') }} st ON me.user_id = st.user_id
    WHERE 
        me.event_timestamp <= st.transaction_timestamp
)

SELECT 
    total_marketing_cost,
    total_acquisitions,
    total_revenue,
    total_events,
    -- Cost per Acquisition (CPA)
    CASE 
        WHEN total_acquisitions > 0 THEN total_marketing_cost / total_acquisitions 
        ELSE 0 
    END AS cost_per_acquisition,
    
    -- Return on Marketing Investment (ROMI)
    CASE 
        WHEN total_marketing_cost > 0 THEN (total_revenue - total_marketing_cost) / total_marketing_cost 
        ELSE 0 
    END AS romi,
    
    -- Event Conversion Rate
    CASE 
        WHEN total_events > 0 THEN (total_transactions * 100.0) / total_events 
        ELSE 0 
    END AS event_conversion_rate
FROM 
    marketing_data