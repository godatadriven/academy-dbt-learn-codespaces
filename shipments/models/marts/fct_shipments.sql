with shipments as (
    select * from {{ ref('base_swift_transactions_shipments')}}
)

select * from shipments