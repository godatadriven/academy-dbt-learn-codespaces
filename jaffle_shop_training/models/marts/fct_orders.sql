with customers as (

    select
        *
    from {{ ref('stg_jaffle_shop__customers')}}

),

orders as (

    select
        *
    from {{ ref('stg_jaffle_shop__orders')}}

),

payments as (

    select
        *
    from {{ ref('stg_stripe__payments')}}

),



final as (

    select
        o.order_id,
        c.customer_id,
        o.order_date,
        p.amount
    from orders o
    left join customers c
        on o.customer_id = c.customer_id
    left join payments p
        on o.order_id = p.order_id

)

select * from final
