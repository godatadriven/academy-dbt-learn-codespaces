with 

source as (

    select * from {{ source('stripe', 'payment') }}

),

renamed as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        lower (status) as order_status,
        amount / 100 as payment_amount,
        created,
        _batched_at

    from source

)

select * from renamed

