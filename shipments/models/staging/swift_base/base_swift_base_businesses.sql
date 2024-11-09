with source as (
      select * from {{ source('swift_base', 'businesses') }}
),
renamed as (
    select
        id,
        name,
        address,
        country,

    from source
)
select * from renamed
  