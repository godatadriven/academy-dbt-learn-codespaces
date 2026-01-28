select 
order_id,
payment_id,
sum(amount) as sales
from {{ ref('stg_stripe__payments') }}
 group by order_id,payment_id