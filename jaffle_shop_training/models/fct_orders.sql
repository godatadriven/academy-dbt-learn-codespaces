{{ 
    config(
        materialized='view'
          )
}}

with payments as 
(

    select
        payment_id,
        order_id,
        payment_status,
        amount
    from {{ ref("stg_stripe__payments") }}

),

orders as (

    select
        order_id,
        customer_id,
        order_date,
        status

    from {{ ref("stg_jaffle_shop__orders") }}

    ),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        payments.amount
    from orders

    left join payments using (order_id)

)

select * from final