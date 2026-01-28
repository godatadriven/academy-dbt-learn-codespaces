with payments as (

    select
        *
    from {{ ref("stg_stripe__payments") }}

),

orders as (

    select
        *
    from {{ ref("stg_jaffle_shop__orders") }}

),

order_payments as (

    select
        order_id,
        payment_status,
        sum(amount) as order_amount

    from  payments

    group by all

)

select * from order_payments