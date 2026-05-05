with customers as (

    -- Base customer attributes
    select *
    from {{ ref("stg_jaffle_shop__customers") }}

),

orders as (

    -- Orders linked to customers
    select *
    from {{ ref("stg_jaffle_shop__orders") }}

),

payments as (

    -- Successful payments aggregated at the order level
    select
        payment_order_id,
        sum(amount) / 100 as amount
    from {{ ref("stg_stripe__payments") }}
    where payment_status != 'fail'
    group by payment_order_id

),

customer_orders as (

    -- Order-level metrics per customer
    select
        o.customer_id,
        min(o.order_date) as first_order_date,
        max(o.order_date) as most_recent_order_date,
        count(o.order_id) as number_of_orders
    from orders o
    group by o.customer_id

),

customer_lifetime_value as (

    -- Lifetime value aggregated at the customer level
    select
        o.customer_id,
        sum(p.amount) as lifetime_value
    from orders as o 
    left join payments p on o.order_id = p.payment_order_id
    group by 1

),

final as (

    -- Final customer dimension (one row per customer)
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        co.first_order_date,
        co.most_recent_order_date,
        coalesce(co.number_of_orders, 0) as number_of_orders,
        coalesce(clv.lifetime_value, 0) as lifetime_value
    from customers c
    left join customer_orders co
        on c.customer_id = co.customer_id
    left join customer_lifetime_value clv
        on c.customer_id = clv.customer_id

)

select *
from final