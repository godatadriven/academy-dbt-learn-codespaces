with orders as (
    SELECT * FROM {{ ref('stg_jaffle_shop__orders') }}
),
accepted_payment as (
    SELECT * FROM {{ ref('stg_stripe__payment') }}
    where status = 'success'
)

SELECT 
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    sum(accepted_payment.amount) as amount
FROM orders
JOIN accepted_payment
ON accepted_payment.order_id = orders.order_id
GROUP BY 1,2,3