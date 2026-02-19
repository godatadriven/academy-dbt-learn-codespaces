{{ config(materialized="view") }}

with
    customers as (

        select * from {{ ref("stg_jaffle_shop__customers") }}

    ),

    orders as (

        select * from {{ ref('fct_orders') }}

    ),



    customer_orders as (

        select
            customer_id,

            min(order_date) as first_order_date,
            max(order_date) as most_recent_order_date,
            count(order_id) as number_of_orders,
            sum(order_amount) as customer_lifetime_value
        from orders o

        group by 1

    ),

    final as (

        select
            c.customer_id,
            c.first_name,
            c.last_name,
            co.first_order_date,
            co.most_recent_order_date,
            co.customer_lifetime_value,
            coalesce(co.number_of_orders, 0) as number_of_orders

        from customers c

        left join customer_orders co using (customer_id)

    )

select *
from final
