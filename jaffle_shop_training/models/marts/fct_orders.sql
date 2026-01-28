with payments as (
    select
        payment_id,
        order_id,
        payment_method,
        sum(sales) as summed_amount,
        status
    from {{ ref('stg_stripe__payments') }}
    where status != 'fail'
    group by 1, 2, 3, 5
),

orders as (
    select
        order_id,
        customer_id,
    from {{ ref('stg_jaffle_shop__orders') }}
),

summed_orders as (
    select
        orders.customer_id,
        payments.order_id,
        payments.summed_amount
    from payments
    left join orders on (payments.order_id = orders.order_id)
)

select * from summed_orders