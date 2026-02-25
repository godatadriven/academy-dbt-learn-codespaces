{% set payment_methods_values = dbt_utils.get_column_values(
    table=ref("stg_stripe__payments"), column="payment_method"
) %}
-- {{payment_methods_values}}

select
    order_id,
    {% for payment_method in payment_methods_values -%}
        sum(case when payment_method = '{{payment_method}}' then payment_amount else 0 end) as {{ payment_method }}
        {% if not loop.last -%}
            , 
        {%- endif -%}

    {%- endfor -%}
from {{ ref("stg_stripe__payments") }}
group by all
