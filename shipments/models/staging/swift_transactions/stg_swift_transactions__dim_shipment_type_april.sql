with 

source as (

    select * from {{ source('swift_transactions', 'dim_shipment_type_april') }}

),

renamed as (

    select
        shipment_type,
        price_per_kg,
        shipment_type_id

    from source

)

select * from renamed
