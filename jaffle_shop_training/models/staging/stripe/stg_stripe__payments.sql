with 

source as (

    select * from {{ source('stripe', 'payments') }}

),

renamed as (

    select
        id as payment_id,
        orderid as order_id,
        status as payment_status,
        amount/100 as amount,
        created as payment_created
    from source

)

select * from renamed