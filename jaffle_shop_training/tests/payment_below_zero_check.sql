with payments as 
    (
    select * 
    from {{ ref('stg_payments') }}
    )

select  order_id,
        status,
        sum(amount) as total_amount
from    payments
where   status = 'success'
group   by all

having  sum(amount) < 0