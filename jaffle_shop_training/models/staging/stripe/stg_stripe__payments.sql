with 

source as (

    select * from {{ source('stripe', 'payment') }}

),
renamed as (

    select
      id            as payment_id,
      orderid       as order_id,
      PAYMENTMETHOD as payment_method,
      AMOUNT/100        as payment_amount,
      CREATED       as payment_created,
      _BATCHED_AT  as payment_batch_at

    from source

)

select * from renamed