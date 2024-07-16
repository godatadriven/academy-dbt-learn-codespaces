with orders as (
    select * from {{ ref('stg_jaffle_shop_orders') }}
),

grouped_payments as (
    select 
        order_id,
        sum(payment_amount) as order_amount
    from {{ ref('stg_stripe_payments') }}
    where payment_status = 'success'
    group by 1
)

select 
    orders.*,
    grouped_payments.order_amount
from orders 
left join grouped_payments on orders.order_id=grouped_payments.order_id