
/*
   This model will simply select and clean the sales transactions data.
   
    create table for monthly_marketing_costs table 
*/

{{ config(materialized='table') }}
SELECT
    EXTRACT(YEAR FROM event_timestamp) AS event_year,
    EXTRACT(MONTH FROM event_timestamp) AS event_month,
    EXTRACT(DAY FROM event_timestamp) AS event_day,
    SUM(cost) AS monthly_marketing_cost
FROM{{ source('dev', 'marketing_events') }}
GROUP BY 1, 2,3