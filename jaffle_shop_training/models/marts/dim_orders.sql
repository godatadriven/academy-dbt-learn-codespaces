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

    from {{ ref('stg_jaffle_shop__orders') }}
),

payments as (
    select order_id,status,sum(amount) as amount from {{ ref('stg_stripe__payment') }}
where status='success'
group by order_id,status

)
,

orders_value as (
select orders.order_id,customers.customer_id,orders.order_date,orders.status as order_status, payments.amount from orders 
inner join customers on orders.customer_id=customers.customer_id
left join payments on orders.order_id=payments.order_id

),

life_time_value as (
select orders_value.customer_id,sum(amount) as lifetime_value from orders_value 
group by orders_value.customer_id

)

select orders_value.*,life_time_value.lifetime_value from orders_value 
left join life_time_value on orders_value.customer_id=life_time_value.customer_id
