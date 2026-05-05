/*
select payment_order_id,
{% for payment_method in ['credit_card', 'gift_card', 'bank_transfer', 'coupon'] %}
    sum( case when payment_method = '{{ payment_method }}' then amount else 0 end ) as {{ payment_method }}_amount,
{% endfor %}
--,sum( case when  payment_method)
from {{ ref("stg_stripe__payments") }}
group by 1*/

-- * Use a set at the top of the file to make payment_methods
-- * Whitespace control in the compiled output
-- ** Remove the trailing comma
-- *** can we ask SQL what the distinct values are? -- YES but you need a package 
-- **** make this into a macro 

{% set payment_methods = ['credit_card', 'gift_card', 'bank_transfer', 'coupon'] %}
{{pivot_payments_by_method(payment_methods)}}


--{% set payment_method dbt_utils.get_column_values('stripe','payment'), 'payment_method' %}

