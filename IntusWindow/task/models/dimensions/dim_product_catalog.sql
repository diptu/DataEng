
/*
   This model will simply select and clean the sales transactions data.
   
    create table for dim_product_catalog table 
*/
{{ config(materialized='table') }}

SELECT
    product_id,
    product_name,
    category
FROM {{ source('dev', 'product_catalog') }}