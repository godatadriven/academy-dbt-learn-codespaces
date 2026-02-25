-- get rid of last comma
-- get rid of unnecessary whitespace
-- set the list at the top of the model
-- pull the values of payment_method from the column in the table

{%- set payment_methods = dbt_utils.get_column_values(
    table=ref('stg_stripe__payments'), 
    column='payment_method') 
    %}
-- {% set payment_methods = ['credit_card','bank_transfer','gift_card','coupon'] %}
--  {{ payment_methods}}

select 
    order_id,
{% for payment_method in payment_methods %}
    {%- if loop.first is false -%}
    ,
    {%- endif -%}
    sum (case when payment_method = '{{payment_method}}' then payment_amount else 0 end) as {{payment_method}}_amount
{% endfor %}
from {{ ref ('stg_stripe__payments')}}
group by all