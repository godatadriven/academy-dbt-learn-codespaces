with orders as (

    select
        order_id,
        customer_id,
        order_date,
        status

    from {{ ref("stg_jaffle_shop__orders") }}

),

payments as (

    select
        order_id,
        sum(amount) as amount
    from {{ ref("stg_stripe__payment") }}
    where status = 'success' 
    group by 1

    
),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        payments.amount as amount
    from orders
    left join payments
        on orders.order_id = payments.order_id
    where amount is not null


)

select * from final