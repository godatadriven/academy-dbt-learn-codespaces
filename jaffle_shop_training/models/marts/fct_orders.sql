{{
    config(
        materialized='table'
    )
}}

with orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),
 payments as (
    select * from {{ ref('stg_stripe__payments') }}
),
 final as (

select 
o.order_id,
o.customer_id,
o.order_date,
o.order_status,
sum(p.amount) as amount
from orders o
left join payments p on p.order_id = o.order_id
where 1=1
--and order_status in ('shipped','completed','placed','return_pending')
and p.payment_status = 'success'
group by all
)

select * from final