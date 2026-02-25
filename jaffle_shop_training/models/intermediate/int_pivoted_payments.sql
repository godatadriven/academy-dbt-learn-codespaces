{% set payment_method_list = dbt_utils.get_column_values(
    table=ref("stg_stripe__payments"), column="payment_method"
) %}
-- {{ payment_method_list }}

select
    order_id,
    {{ create_surrogate('payment_id', 'order_id') }} as order_sk,
    {%- for payment_method in payment_method_list -%}
        sum(
            case
                when payment_method = '{{ payment_method }}' then payment_amount else 0
            end
        ) as {{ payment_method }}_amount
        {%- if not loop.last -%}, {% endif %}
    {% endfor %}
from {{ ref("stg_stripe__payments") }}
group by 1, 2



