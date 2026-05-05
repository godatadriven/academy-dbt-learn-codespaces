{% macro pivot_payments_by_method(
    payment_methods,
    source_relation = ref("stg_stripe__payments"),
    order_id_column='payment_order_id',
    payment_method_column='payment_method',
    amount_column='amount'
) %}

select
    {{ order_id_column }},
    {% for payment_method in payment_methods %}
        sum(case when {{ payment_method_column }} = '{{ payment_method }}' then {{ amount_column }} else 0 end
        ) as {{ payment_method }}_amount{% if not loop.last %},{% endif %}
    {% endfor %}
from {{ source_relation }}
group by {{ order_id_column }}

{% endmacro %}