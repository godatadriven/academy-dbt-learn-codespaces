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
orders as (

    select 
        o.customer_id,
        o.order_date,
        o.order_id,
        p.amount,
        p.status as payment_status

    from {{ ref('stg_jaffle_shop__orders')}} as o
    left join payments as p on p.order_id = o.order_id

),

customer_orders as (

    select
        customer_id,

        min(orders.order_date) as first_order_date,
        max(orders.order_date) as most_recent_order_date,
        count(orders.order_id) as number_of_orders,  
        SUM(CASE WHEN orders.payment_status = 'success' THEN orders.amount ELSE 0 END) AS lifetime_value,
        SUM(CASE WHEN orders.payment_status != 'success' THEN orders.amount ELSE 0 END) AS failed_amount,
   
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
        customer_orders.lifetime_value,
        customer_orders.failed_amount,

        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final