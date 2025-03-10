with source as (
      select * from {{ source('swift_base', 'businesses') }}
),
renamed as (
    select
        id as business_id,
        name as business_name,
        address as business_address,
        country as business_country,

    from source
)
select * from renamed
  