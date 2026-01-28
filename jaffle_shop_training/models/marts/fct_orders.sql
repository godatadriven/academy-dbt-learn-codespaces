{{
    config(
        materialized='view'
    )
}}

with customers as (

    select
        *
    from {{ ref("stg_jaffle_shop__customers") }}

),

orders as (

    select
        *

    from {{ ref("stg_jaffle_shop__orders") }}

),

payments as (

    select
        *

    from {{ ref("stg_stripe__payment") }}

    where status = 'success'

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        orders.order_id,
        sum(payments.amount) / 100 as amount

    from customers

    left join orders using (customer_id)
    left join payments using (order_id)

    group by all

)

select * from final