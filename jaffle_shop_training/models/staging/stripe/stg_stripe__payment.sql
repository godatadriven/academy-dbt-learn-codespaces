with 

source as (

    select * from {{ source('stripe', 'payment') }}

),

renamed as (

    select
          id                as payment_id
        , orderid           as order_id
        , paymentmethod     as payment_method
        , status            as payment_status
        , amount/100        as amount
        , created           as created
        , _batched_at       as _batched_at

    from source

)

select * from renamed