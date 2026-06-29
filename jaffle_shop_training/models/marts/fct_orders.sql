with orders as (

    select
        *

    from {{ ref('stg_jaffle_shop__orders') }}

)

, payment as (
    select
        *

    from {{ ref('stg_stripe__payment') }}
)

select 
  o.order_id        as order_id
, o.customer_id     as customer_id
, o.order_date      as order_date
, o.order_status    as order_status
, sum(p.amount)     as payment_amount
from orders o
left join payment p
    on  o.order_id = p.order_id   
    and p.payment_status = 'success' 
group by all