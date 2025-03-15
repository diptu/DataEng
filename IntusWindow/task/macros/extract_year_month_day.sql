/*
This macro extracts the year, month, and day components from a timestamp column.
*/
{% macro extract_year_month_day(transaction_timestamp) %}
    EXTRACT(YEAR FROM {{ transaction_timestamp }}) AS transaction_year,
    EXTRACT(MONTH FROM {{ transaction_timestamp }}) AS transaction_month,
    EXTRACT(DAY FROM {{ transaction_timestamp }}) AS transaction_day,
{% endmacro %}