{% test assert_order_date_in_past(model, column_name) %}

with validation as (

    select
        {{ column_name }} as date_field
    from {{ model }}

),

validation_errors as (

    select
        date_field
    from validation
    -- if this is true, then date in past
    where date_field > current_date()

)

select *
from validation_errors

{% endtest %}