/*
   This model will simply select and clean the sales transactions data.

*/




WITH sales_summary AS (
    SELECT
        {{ extract_year_month_day('s.transaction_timestamp') }}
        s.user_id,
        s.product_id,
        s.revenue,
        s.cost
    FROM {{ ref('stg_sales_transactions') }} s
),
daily_sales AS (
    SELECT
        ss.transaction_year,
        ss.transaction_month,
        ss.transaction_day,
        p.category,
        COUNT(DISTINCT ss.user_id) AS unique_customers,
        SUM(ss.revenue) AS total_revenue,
        SUM(ss.cost) AS total_sales_cost
    FROM sales_summary ss
    LEFT JOIN {{ ref('dim_product_catalog') }} p ON ss.product_id = p.product_id
    GROUP BY 1, 2, 3, 4
),
daily_events AS (
    SELECT
        EXTRACT(YEAR FROM me.event_timestamp) AS event_year,
        EXTRACT(MONTH FROM me.event_timestamp) AS event_month,
        EXTRACT(DAY FROM me.event_timestamp) AS event_day,
        COUNT(me.event_id) AS total_marketing_events
    FROM {{ref('stg_marketing_events')}} me
    GROUP BY 1, 2, 3
),
daily_marketing_costs AS (
    SELECT
        EXTRACT(YEAR FROM me.event_timestamp) AS event_year,
        EXTRACT(MONTH FROM me.event_timestamp) AS event_month,
        EXTRACT(DAY FROM me.event_timestamp) as event_day,
        SUM(me.cost) as daily_marketing_cost
    FROM demo.dev.stg_marketing_events me
    GROUP BY 1,2,3
)
SELECT
    ms.transaction_year,
    ms.transaction_month,
    ms.transaction_day,
    ms.category,
    ms.unique_customers,
    ms.total_revenue,
    ms.total_sales_cost,
    mmc.daily_marketing_cost AS total_marketing_cost,
    me.total_marketing_events,
    CASE
        WHEN ms.total_sales_cost > 0 THEN (ms.total_revenue / ms.total_sales_cost)
        ELSE 0
    END AS revenue_to_cost_ratio
FROM daily_sales ms
LEFT JOIN daily_marketing_costs mmc
    ON ms.transaction_year = mmc.event_year
    AND ms.transaction_month = mmc.event_month
    AND ms.transaction_day = mmc.event_day
LEFT JOIN daily_events me
    ON ms.transaction_year = me.event_year
    AND ms.transaction_month = me.event_month
    AND ms.transaction_day = me.event_day
ORDER BY ms.transaction_year, ms.transaction_month, ms.category
