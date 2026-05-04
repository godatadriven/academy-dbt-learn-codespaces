{% test is_negative(model, column_name) %}

with validation as (

    select
        {{ column_name }} as numerical_field

    from {{ model }}

),

validation_errors as (

    select
        numerical_field

    from validation
    -- if this is true, then even_field is actually odd!
    where numerical_field < 0

)

select *
from validation_errors

{% endtest %}