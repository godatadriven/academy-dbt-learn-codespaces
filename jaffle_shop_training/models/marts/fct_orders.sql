with
 customers as (

    select
        *
    from {{ ref("stg_jaffle_shop__customers") }}

),

orders as (

    select

        *

    from {{ ref("stg_jaffle_shop__orders")}}


),

payments as (

    select
        order_id,
        sum(amount)/100 as amount_per_order
    from {{ ref("stg_stripe__payments") }}
    where payment_status = 'success'
    group by order_id

),

joined as(

    select
        *
    from customers
    left join orders using (customer_id)
    left join payments using (order_id)
    
    

),

final as(

    select customer_id,
    sum(joined.amount_per_order) as total
    from joined
    group by customer_id

)


select * from final