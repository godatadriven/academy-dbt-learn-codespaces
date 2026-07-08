with 

source as (

    select * from {{ source('stripe', 'payments') }}

),

renamed as (

    select
        orderid as order_id,
        status,
        amount/100 as amount

    from source    
)

select * from renamed