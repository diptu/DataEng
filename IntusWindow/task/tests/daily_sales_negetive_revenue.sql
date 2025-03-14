SELECT *
FROM {{ ref('daily_sales_summary') }} 
where total_revenue < 0