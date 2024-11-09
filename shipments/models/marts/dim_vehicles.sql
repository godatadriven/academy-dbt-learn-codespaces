with vehicles as (
    select * from {{ref("base_swift_carrier_vehicles") }}
)

select * from vehicles