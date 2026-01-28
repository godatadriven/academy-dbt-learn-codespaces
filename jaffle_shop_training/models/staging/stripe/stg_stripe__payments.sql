with 

source as (

    select * from {{ source('stripe', 'payments') }}

),

renamed as (

    select
        id as customer_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status as payment_status,
        amount,
        created,
        _batched_at

    from source

)

select * from renamed