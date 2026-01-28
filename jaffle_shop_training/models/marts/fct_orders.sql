with payments as (

    select
        *
    from {{ ref("stg_stripe__payments") }}
    where payment_status = 'success'

),

customers as (

    select
        *
    from {{ ref("stg_jaffle_shop__customers") }}

),

orders as (

    select
        *
    from {{ ref("stg_jaffle_shop__orders") }}

),
sum_orders as (
    select 
        order_id
        , sum(amount)/100 AS amount
    from payments
    group by 1
),

paid_orders as (

    select
        customers.customer_id
        , orders.order_id
        , sm.amount
    from customers customers
    inner join orders orders
        on customers.customer_id = orders.customer_id
    left join sum_orders sm
        on sm.order_id = orders.order_id
    

)

select * from paid_orders