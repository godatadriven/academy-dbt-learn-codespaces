with customers as (
    select * from {{ref("base_swift_base_customers") }}
)

select * from customers