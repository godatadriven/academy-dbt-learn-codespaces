with payments as (

    select
    *
    from {{ ref('stg_stripe__payments') }}
    where payment_status = 'success'

),

orders as (
    select
    *
    from {{ ref('stg_jaffle_shop__orders') }}
),


payment_orders as (
    select
    order_id,
    sum(payment_amount) as order_amount

    from payments p
    group by 1
),

final as (

    select
        orders.*,
        {{create_surrogate_key('order_id','customer_id')}} as surrogate_key,
        {{create_surrogate_key_hash('order_id','customer_id')}} as surrogate_key_hash,
        payment_orders.order_amount

    from orders

    left join payment_orders using (order_id)

)

select * from final
