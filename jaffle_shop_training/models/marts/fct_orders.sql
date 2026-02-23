with customers as (
select * from {{ ref('dim_customers') }}
),

orders as (
    select * from {{ ref('fct_orders') }}
),

payments as (
select 
order_id,
payment_id,
sum(amount) as sales
from {{ ref('stg_stripe__payments') }}
 group by order_id,payment_id
)


select
    p.orderid,
    o.id as customerid,
    p.amount
from payments p
left join orders 0
    on p.orderid = 0.orderid
left join customers c
    on o.id = c.id
