with drivers as (
    select * from {{ ref('base_swift_carrier_drivers') }}
)

select * from drivers



