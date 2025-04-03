with orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

payments as (
    select * from {{ ref('stg_stripe__payments') }}
),

pivoted_payments as (
    select * from {{ ref('pivoted_payments') }}
),

grouped_payments as (
    select 
        order_id,
        sum(payment_amount) as order_amount
    from {{ ref('stg_stripe__payments') }}
    where payment_status = 'success'
    group by 1
)

select 
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    orders.order_status,
    pivoted_payments.bank_transfer_amount,
    pivoted_payments.credit_card_amount,
    pivoted_payments.coupon_amount,
    pivoted_payments.gift_card_amount,
    grouped_payments.order_amount as total_order_amount,
    orders._etl_loaded_at,
from orders 
left join grouped_payments on orders.order_id=grouped_payments.order_id
left join pivoted_payments on orders.order_id=pivoted_payments.order_id