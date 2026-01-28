with 

source as (

    select * from {{ source('stripe', 'payments') }}

),

renamed as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod,
        status as payment_status,
        amount,
        created,
        _batched_at

    from source

)

select * from renamed