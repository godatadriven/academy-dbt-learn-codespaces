with 
source as (
    select * from {{ source('stripe', 'payments') }}
),

renamed as (
    select id as payment_id
    ,orderid as payment_order_id
    ,paymentmethod as payment_method
    ,status as payment_status
    ,{{cents_to_dollars(column_name = 'amount')}} as amount
    --,amount
    ,created
    ,_BATCHED_AT
    from source
)

select * from renamed