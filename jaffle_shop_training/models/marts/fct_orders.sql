
with payments as (

    select *
    from {{ref("stg_stripe__payment")}}
    where status in ( 'success')

),

orders as (

    select *
    from {{ref("stg_jaffle_shop__orders")}}

),

customers as (

    select *
    from {{ref("stg_jaffle_shop__customers")}}

)

select 
        o.order_id,
        c.customer_id,
        o.order_date,
        o.status,
        sum(amount) as revenue

from orders as o
left join customers as c on o.customer_id = c.customer_id
left join payments as p on o.order_id = p.order_id
group by all