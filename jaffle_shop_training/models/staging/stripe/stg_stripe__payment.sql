with 

source as (

    select * from {{ source('stripe', 'payment') }}

),

renamed as (

    select
        id,
        orderid as order_id,
        paymentmethod,
        status,
        amount,
        created,
        _batched_at

    from source

)

select * from renamed