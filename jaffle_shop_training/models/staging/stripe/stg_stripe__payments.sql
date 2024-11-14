{# {% set value = 10/0 %} #}

with 

source as (

    select * from {{ source('stripe', 'payments') }}

),

renamed as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status as payment_status,
        {{ convert_cents_to_dollars(column_name='amount') }} as payment_amount,
        created,
        _batched_at

    from source

)

select * from renamed
