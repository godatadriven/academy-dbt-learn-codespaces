with 
orders as (

    select
        *
    from {{ ref("stg_jaffle_shop__orders") }}

),

payments as (
    select
        *
    from {{ ref("stg_stripe__payment") }}
    where
        status = 'success'
),


order_payments as (

    select
        o.order_id,
        o.customer_id,
        o.order_date,

        sum(p.amount) as amount

    from orders o 
    left join payments p
        on o.order_id = p.order_id 
    group by 1, 2, 3
)

select * from order_payments where amount is not null