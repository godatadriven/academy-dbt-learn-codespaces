with payments as 
(
    select 
         order_id
        ,status
        ,amount
    from {{ ref("stg_stripe__payments") }}
),

orders as 
(
    select 
         order_id
        ,customer_id
    from {{ ref("stg_jaffle_shop__orders") }}
),

joined_payments_order as
(
    select 
         payments.order_id
        ,payments.status
        ,orders.customer_id
        ,payments.amount
    from payments
    
    left join orders 
    on payments.order_id = orders.order_id
)


select * from joined_payments_order
where status <> 'fail'
