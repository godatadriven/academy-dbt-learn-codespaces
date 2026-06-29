with 
orders as (
    select
       *
   from {{ ref('stg_jaffle_shop__orders') }}
),

payments as (
    select * from {{ ref('stg_stripe__payments') }}
    where payment_status = 'success'
),

final as
(
select orders.order_id, 
customer_id,
order_date,
order_status,
amount
from orders
inner join payments using(order_id)

)

select * from final
order by amount