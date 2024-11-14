-- set the payment_methods (can we use select distinct??)
-- using a for loop for all the sum/case whens 

{%- set payment_methods = dbt_utils.get_column_values(table=ref("stg_stripe__payments"), column='payment_method') %}

select 

    order_id,

    {% for element in payment_methods -%}
    sum(case when payment_method='{{ element }}' then payment_amount else 0 end) as {{ element }}_amount,
    {% endfor %}

from {{ ref('stg_stripe__payments') }}
group by order_id
order by order_id