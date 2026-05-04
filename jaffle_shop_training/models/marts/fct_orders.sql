with orders as (
    select * from {{ ref("stg_jaffle_shop__orders") }}
),

payments as (
    select * from {{ ref("stg_stripe__payments") }}
),

final as (
    select  
        orders.*
        sum(payments.amount) as order_amount
    from orders
    left join payments using (order_id)
)

select * from final