/*
This generic test checks if a specified numeric column in a model contains only positive values (values greater than 0).

      **Purpose:**

      The `is_positive` test is used to ensure data quality by verifying that a column, which is expected to hold positive numbers, does not contain any zero or negative values. This is useful for columns representing metrics like revenue, counts, or other quantities that should naturally be positive.

*/

{% test is_positive(model, column_name) %}

with validation as (
    select
        {{ column_name }} as positive_field
    from {{ model }}
),

validation_errors as (
    select
        positive_field
    from validation
    -- if this is true, then positive_field is negetive!
    where positive_field <= 0  -- Change to check for non-positive values
)

select *
from validation_errors

{% endtest %}