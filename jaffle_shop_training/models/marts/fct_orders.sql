{{
    config(
        materialized='view'
    )     
}}

with customers as (

    select *
    from {{ ref('stg_jaffle_shop__customers') }}

),
payments as (

    select *
    from {{ ref('stg_stripe__payments') }}
),

customer_orders as (

    select orders.order_id,
           orders.customer_id,
           orders.order_date,           
           orders.status,
           payments.amount,           
           payments.status as payment_status

    from {{ ref('stg_jaffle_shop__orders')}} orders
    left join payments payments on orders.order_id = payments.order_id

),

final as (

    select
        orders.order_id,
        customers.customer_id,
        orders.order_date,
        orders.status,
        orders.payment_status,
        orders.amount

    from customer_orders as orders
    left join customers using (customer_id)
)

select * from final