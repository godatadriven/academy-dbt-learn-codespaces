with orders as (
    select
        order_id,
        customer_id,
        order_date
    from {{ ref('stg_jaffle_shop__orders') }}
),

payments as (
    select
        payment_order_id,
        sum(amount) as amount
    from {{ ref('stg_stripe__payments') }}
    where payment_method != 'fail'
    and amount is not null
    group by 1
)

select
    o.order_id,
    o.customer_id,
    o.order_date,
    coalesce(p.amount, 0) as amount
from orders o
left join payments p on o.order_id = p.payment_order_id