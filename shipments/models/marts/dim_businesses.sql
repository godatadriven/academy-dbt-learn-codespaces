with businesses as (
    select * from {{ref("base_swift_base_businesses") }}
)

select * from businesses