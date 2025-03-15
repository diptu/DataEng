{{ config(materialized='ephemeral') }}

WITH monthly_actual_revenue
AS (
	SELECT 
        EXTRACT(YEAR FROM transaction_timestamp) AS transaction_year,
        EXTRACT(MONTH FROM transaction_timestamp) AS transaction_month,
        pc.category,
		SUM(st.revenue) AS actual_revenue
	FROM {{ ref('stg_sales_transactions') }} st
	LEFT JOIN {{ ref('dim_product_catalog') }} pc ON st.product_id = pc.product_id
	GROUP BY 1,2,3
),
target_vs_actual AS (
	SELECT 
        tr.transaction_year,
        tr.transaction_month,
		tr.category,
		tr.target_revenue,
		mar.actual_revenue,
		CASE 
			WHEN mar.actual_revenue >= tr.target_revenue
				THEN 'Achieved'
			ELSE 'Not Achieved'
			END AS target_achievement_status
	FROM {{ ref('sales_target') }} tr
	LEFT JOIN monthly_actual_revenue mar ON tr.transaction_year = mar.transaction_year
		AND tr.transaction_month = mar.transaction_month
		AND tr.category = mar.category
	)
SELECT transaction_year
	,transaction_month
	,category
	,target_revenue
	,actual_revenue
	,target_achievement_status
FROM target_vs_actual
ORDER BY transaction_year,transaction_month,category;
