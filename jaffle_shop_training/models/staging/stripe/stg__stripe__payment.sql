with source as 
    (
    select  id,
            orderid,
            paymentmethod,
            status,
            amount,
            created
    from   {{ source('stripe', 'payment') }}
    ),

renamed as
    (
    select
        id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        amount /100,
        created
    from source
    )

select * from renamed


