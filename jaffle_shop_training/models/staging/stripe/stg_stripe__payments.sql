with source as (
      select * from {{ source('stripe', 'payments') }}
),
renamed as (
    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status as payment_status,
        {{ cents_to_dollars('amount') }} as payment_amount,
        created as created_at,
        _batched_at as _batched_at

    from source
)
select * from renamed
  