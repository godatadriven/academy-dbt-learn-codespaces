-- get rid of the unnecessary whitespace
-- get rid of the last trailing comma
-- set the list at the top of the model
-- pull the values of payment_method from the column in the table (this will need a package!)

select 
    order_id,
{% for payment_method in ['credit_card', 'bank_transfer', 'coupon', 'gift_card'] %}
    sum(case when payment_method = '{{ payment_method }}' then payment_amount else 0 end) as {{ payment_method }}_amount,
{% endfor %}
from {{ ref('stg_stripe__payments') }}
group by 1