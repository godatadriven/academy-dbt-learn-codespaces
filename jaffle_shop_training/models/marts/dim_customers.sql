with customers as (

    select
        customer_id,
        first_name,
        last_name
    from {{ ref('stg_jaffle_shop__customers') }}

),

orders as (

    select
        order_id,
        customer_id,
        order_date,
        status

    from {{ ref("stg_jaffle_shop__orders") }}

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

payments as (

    select
        orders.customer_id,
        sum(amount)/100 as amount
    from {{ ref("stg_stripe__payment") }}
    left join orders using (order_id) 
    where status = 'success' 
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
        amount as total_spent

    from customers

    left join customer_orders using (customer_id)
    left join payments using (customer_id)

    where total_spent is not null

)

select * from final