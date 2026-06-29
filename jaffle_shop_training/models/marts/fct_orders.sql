with customers as (

    select
    customer_id,
        first_name,
        last_name
   from {{ ref('stg_jaffle_shop__customers') }}

),

orders as (

    select
        order_id,
        customer_id,
        order_date,
        order_status

   from {{ ref('stg_jaffle_shop__orders') }}
   
   ),

   payment as (   
    select
    customer_id,
    order_id,
    payment_method,
    payment_status,
    payment_amount
 from {{ ref('stg_stripe__payment') }}
   ),

payment_order as (

    select
     order_id, 
     sum(payment_amount) as payment_amount
             

    from payment

    group by 1

),

final as (

    select
        order_id,
        customer_id,
        order_date,
        order_status,
        payment_amount

    from payment

    left join orders using (order_id)

)

select * from final