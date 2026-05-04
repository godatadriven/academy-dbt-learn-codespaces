with customers as (

    select
        *
    from {{ ref('stg_jaffle_shop__customers')}}

),

orders as (

    select
        *
    from {{ ref('stg_jaffle_shop__orders')}}

),

payments as (

    select
        *
    from {{ ref('stg_stripe__payments')}}
    where status = 'success'

),



final as (

    select
        orders.order_id,
        customers.customer_id,
        orders.order_date,
        payments.amount
    from orders orders
    left join customers customers
        on orders.customer_id = customers.customer_id
    left join payments payments
        on orders.order_id = payments.order_id

)

select * from final
