select payment_order_id,
{% for payment_method in ['credit_card', 'gift_card', 'bank_transfer', 'coupon'] %}
    sum( case when payment_method = '{{ payment_method }}' then amount else 0 end ) as {{ payment_method }}_amount,
{% endfor %}
sum(amount) as total_amount
--,sum( case when  payment_method)
from {{ ref("stg_stripe__payments") }}
group by 1