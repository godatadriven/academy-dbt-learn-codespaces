with payment as
(
    select
    order_id,
    payment_id,
    amount/100 as amount
    from {{ ref("stg_stripe__payment") }}
    where payment_status='success'
    group by all

    
),

orders as
(
    select
    order_id,
    customer_id
    from {{ ref("stg_jaffle_shop__orders") }}
),

final as
(
    select
    p.order_id,
    p.amount,
    o.customer_id
    from payment p
    left join orders o on o.order_id=p.order_id
)

select * from final group by all