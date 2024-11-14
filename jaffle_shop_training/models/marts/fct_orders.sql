with orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

payments as (
    select * from {{ ref('stg_stripe__payments') }}
),

order_amounts as (
    select 
        order_id, 
        sum(payment_amount) as order_amount
    from payments
    group by 1
)

select 
    orders.*,
    order_amounts.order_amount
from orders
left join order_amounts using (order_id)
