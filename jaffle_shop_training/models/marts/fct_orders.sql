with payments as
(
    select  * from {{ ref("stg_stripe__payment") }}
    where payment_status='success'
    group by all

    
),

orders as
(
    select * from {{ ref("stg_jaffle_shop__orders") }}
),

   order_payments as (
       select
           order_id,
           sum(payment_amount) as order_amount
       from payments
       group by 1
   ),



final as
(
    select
    o.*,
    p.order_amount
    from orders o
    left join order_payments p using (order_id)
)

select * from final group by all