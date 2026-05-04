with

    orders as (select * from {{ ref("stg_jaffle_shop__orders") }}),

    payments as (select * from {{ ref("stg_stripe__payment") }} where status = 'success'),

    order_payments as (

        select
            order_id,
            sum(amount) as sum_amount,
        
        from payments payments
        
        group by 1

    ),

    final as (

        select order_id,
        order_date,
        customer_id,
        sum_amount
        from orders
        left join order_payments using (order_id)

    )

select *
from final
