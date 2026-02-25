{{
    config
        (
            materialized='view'
        )
}}

with customers as 
    (
        select * from {{ ref('stg_jaffle_shop__customers') }}
    ),

customer_orders as 
    (
        select * from {{ ref('stg_jaffle_shop__orders') }}
    ),

payments as 

    (
        select * from {{ ref('stg_stripe__payments') }}
        where order_status = 'success'
    ),

final as (

    select
        co.order_id,
        c.customer_id,
        sum (p.amount) as amount
    from customers c
    left join customer_orders co using (customer_id)
    left join payments p using (order_id)
    group by all

)
--select sum (amount) from final
select * from final