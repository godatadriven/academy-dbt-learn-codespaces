{{
    config(
        materialized='table',
        tags = 'facts'
    )
}}

with orders as (
select * from {{ ref('stg_jaffle_shop__orders') }}

), 

customers as (
    select * from {{ ref('stg_jaffle_shop__customers') }}
),

payments as (
    select order_id
        ,sum(amount) as amount
        ,sum(case when status <> 'returned' then amount end) as amount_excl_returns
     from {{ ref('stg_stripe__payment') }}

     where status = 'success'
     group by order_id

)

select
    orders.order_id
    ,orders.customer_id
    ,orders.order_date
    ,orders.status as order_status
    ,payments.amount
    ,payments.amount_excl_returns
from
    orders
    left join customers on orders.customer_id = customers.customer_id
    left join payments on orders.order_id = payments.order_id