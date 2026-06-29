with 

source as (

    select * from {{ source('stripe', 'payment') }}

),
renamed as (

    select
        ORDERID as ORDERID,
        ID,
        PAYMENTMETHOD,
        STATUS,
        AMOUNT,
        CREATED,
         _BATCHED_AT,
    from source

)

select * from renamed