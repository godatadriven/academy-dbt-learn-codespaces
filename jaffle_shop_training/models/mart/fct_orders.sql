{{
    config(
        materialized='view'
    )
}}

with customers as (

    select *
    from {{ ref("stg_jaffle_shop__customers")}}

),

orders as (

    select
        order_id,
        customer_id,
        order_date,
        status
    from {{ ref("stg_jaffle_shop__orders") }} 

),

payments as (

    select
       payment_id,
       order_id,
       payment_method,
       payment_amount,
        payment_created,
       payment_batch_at
    from {{ ref("stg_stripe__payments") }} 

),

payment_orders as (

    select
        order_id,
        sum(payment_amount) as order_amount 
    from payments payments 

    group by 1

),


final as (

    select
        orders.customer_id,
        orders.order_id,
        orders.status as order_status,
        payment_orders.order_amount 

    from orders

    left join payment_orders using (order_id)

)

select * from final