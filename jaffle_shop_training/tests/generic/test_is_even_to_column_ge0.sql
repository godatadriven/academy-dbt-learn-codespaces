{% test is_even(model, column_name) %}

with validation as (

    select
        {{ column_name }} as even_field

    from {{ model }}

),

validation_errors as (

    select
        even_field

    from validation
    -- if this is true, then even_field is actually odd!
    where even_field < 0 or even_field = 0

)

select *
from validation_errors

{% endtest %}