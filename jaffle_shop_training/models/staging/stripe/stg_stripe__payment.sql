with 

source as (

    select * from {{ source('stripe', 'payment') }}

),

renamed as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        {{ cents2dollars(column_name='amount') }} as amount,
        created,
        _batched_at

    from source

)

select * from renamed