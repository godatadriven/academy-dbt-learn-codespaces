with shipments as (
    select * from {{ ref('base_swift_transactions_shipments')}}
    ),

    shipment_types as (
        select * from {{ref('dim_shipment_types')}}
    )

select s.*, t.price_per_kg from shipments s left join shipment_types t
    on extract(month from s.label_creation_date) = t.month
    and s.shipment_type_id = t.shipment_type_id