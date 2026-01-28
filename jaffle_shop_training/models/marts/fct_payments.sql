with payments as (

    select
    *
    from {{ ref('stg_stripe__payments') }}
    where status = 'success'

),

orders as (
    select
    *
    from {{ ref('stg_jaffle_shop__orders') }}
),

payment_orders as (
    select
    order_id,
    sum(p.amount)/100 as amount

    from payments p
    group by 1
),

final as (

    select
        orders.order_id,
        orders.customer_id,
        payment_orders.amount

    from orders

    left join payment_orders using (order_id)

)

select * from final
