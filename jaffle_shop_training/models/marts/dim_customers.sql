with customers as (

    select *
    from {{ ref('stg_jaffle_shop__customers') }}

),

orders as (

    select *
    from {{ ref('stg_jaffle_shop__orders') }}

),

payments as (

    select *
    from {{ ref('stg_stripe_data__payment') }}

),

order_payments as (

    select
        order_id,
        sum(amount) as order_amount
    from payments
    group by 1

),

customer_orders as (

    select
        orders.customer_id,
        min(orders.order_date) as first_order_date,
        max(orders.order_date) as most_recent_order_date,
        count(orders.order_id) as number_of_orders,
        sum(coalesce(order_payments.order_amount, 0)) as lifetime_spent_amount
    from orders
    left join order_payments
        on orders.order_id = order_payments.order_id
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
        coalesce(customer_orders.lifetime_spent_amount, 0) as lifetime_spent_amount
    from customers
    left join customer_orders
        on customers.customer_id = customer_orders.customer_id

)

select *
from final