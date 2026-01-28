{{ config(materialized="view") }}


with
    customers as (

        select customer_id, first_name, last_name
        from {{ ref("stg_jaffle_shop__customers") }}

    ),

    orders as (

        select order_id, customer_id, revenue
        from {{ ref('fct_orders') }}

    ),

    customer_orders as (

        select
            customer_id,
            count(orders.order_id) as number_of_orders,
            sum(revenue) as lifetime_value

        from orders

        group by all

    ),

    final as (

        select
            customers.customer_id,
            customers.first_name,
            customers.last_name,
            coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
            coalesce(customer_orders.lifetime_value, 0) as lifetime_value
        from customers

        left join customer_orders using (customer_id)

    )

select *
from final
