with 

source as (

    select * from {{ source('stripe', 'payments') }}

),

renamed as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        {{convert_to_euros('amount',3)}} as payment_amount,
        created,
        _batched_at
    from source

)

select * from renamed

-- select distinct(paymentmethod) from renamed