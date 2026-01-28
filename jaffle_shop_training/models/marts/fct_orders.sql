with    orders_success as 
        (
        select  id,
                order_id,
                payment_method,
                status,
                amount,
                created
        from    {{ ref('stg__stripe__payment') }}
        where   status = 'success'
        ),

        orders_to_customer as
        (
        select order_id,
               customer_id
        from   {{ ref('stg_jaffle_shop__orders') }}
        where  status = 'completed'
        )

select  orders_success.order_id,
        orders_to_customer.customer_id,
        sum(orders_success.amount) as revenue
from    orders_success
left    join orders_to_customer on orders_success.order_id = orders_to_customer.order_id
group   by all