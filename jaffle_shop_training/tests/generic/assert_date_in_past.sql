{% test assert_date_in_past(model, column_name) %}

select *
from {{ model }}
where {{ column_name }} > current_date()

{% endtest %}