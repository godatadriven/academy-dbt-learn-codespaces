with 

source as (

    select * from {{ source('stripe', 'payments') }}

),

renamed as (

    select
          id                AS payment_id
        , orderid           AS order_id
        , paymentmethod     AS payment_method
        , status            AS payment_status
        , amount
        , created           AS created_at
        , _batched_at

    from source

)

select * from renamed