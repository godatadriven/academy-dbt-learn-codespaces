with orders as (

    select
        order_id,
        customer_id,
        order_date,
        status
    from {{ ref("stg_jaffle_shop__orders") }}

),

customers as (

    select
        customer_id
    from {{ ref("stg_jaffle_shop__customers") }}

),

payments as (

    select
        payment_id,
        order_id,
        amount
    from {{ ref("stg_stripe__payment") }}

),

order_payments as (

    select
        order_id,
        sum(amount) as total_amount
    from payments
    group by order_id

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        coalesce(order_payments.total_amount, 0) as total_amount

    from orders

    inner join customers using (customer_id)

    left join order_payments using (order_id)

)

select * from final