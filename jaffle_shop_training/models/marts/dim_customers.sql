{{
    config(
        materialized='view',
        tags='hourly'
    )
}}

with customers as (

    select
        *
    from {{ ref('stg_jaffle_shop__customers') }}

),

orders as (

    select
        *
    from {{ ref('stg_jaffle_shop__orders') }}

),


customer_orders as (

    select
        customer_id,

        min(orders.order_date) as first_order_date,
        max(orders.order_date) as most_recent_order_date,
        count(orders.order_id) as number_of_orders

    from  orders 

    group by 1

),

payments as (
    select
        order_id
        ,sum(amount) as order_amount
    from {{ ref('stg_stripe__payment') }}
    where status = 'success'
    group by 1

),

customer_payments as (
select
    orders.customer_id,
    sum(payments.order_amount) as lifetime_value
from payments
left join orders using (order_id)
group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        customer_payments.lifetime_value

    from customers

    left join customer_orders using (customer_id)
    left join customer_payments using (customer_id)

)

select * from final