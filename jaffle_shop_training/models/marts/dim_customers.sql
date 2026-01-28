{{ config(materialized="view") }}

with
    customers as (

        select 
        customer_id, 
        first_name, 
        last_name 
        from {{ ref("stg_jaffle_shop__customers") }}

    ),

    orders as (

        select 
         *

        from {{ ref('stg_jaffle_shop__orders') }}

    ),

    customer_value as
    (
        select
        customer_id,
        sum(amount) as customer_lifetime_value
        from {{ ref("fct_orders") }}
        group by customer_id

    ),

    customer_orders as (

        select
            customer_id,

            min(orders.order_date) as first_order_date,
            max(orders.order_date) as most_recent_order_date,
            count(orders.order_id) as number_of_orders

        from orders orders

        group by 1

    ),

    final as (

        select
            customers.customer_id,
            customers.first_name,
            customers.last_name,
            customer_orders.first_order_date,
            customer_orders.most_recent_order_date,
            customer_value.customer_lifetime_value,
            coalesce(customer_orders.number_of_orders, 0) as number_of_orders

        from customers

        left join customer_orders using (customer_id)
        left join customer_value using (customer_id)

    )

select *
from final
