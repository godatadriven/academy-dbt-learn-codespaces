with 

source as (

    select * from {{ source('stripe', 'payment') }}

),

renamed as (

    select
        id as customer_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status as payment_status,
        amount/100 as payment_amount
        

    from source
    where payment_status = 'success'

)

select * from renamed

