with shipment_types as (
    select 
    extract(month from TO_TIMESTAMP(aanmaakdatum / 1000)) as month,
    shipment_type_id,
    z_list_price as list_price,
    replace(WGTKG_123X, ' ', '.')::numeric(16, 2)  as weight_in_kg,
    from dbt_swift_production.fct_shipments
    order by month, shipment_type_id
),

union_stategy_price as (
    select *,
            1 as month
    from dbt_swift_transactions.dim_shipment_type_january

    union all 

    select *,
            2 as month
    from dbt_swift_transactions.dim_shipment_type_february

    union all 

    select *,
            3 as month
    from dbt_swift_transactions.dim_shipment_type_march

    union all 

    select *,
            4 as month
    from dbt_swift_transactions.dim_shipment_type_april

    union all 

    select *,
            5 as month
    from dbt_swift_transactions.dim_shipment_type_may

    union all 

    select *,
            6 as month
    from dbt_swift_transactions.dim_shipment_type_june

    union all 

    select *,
            7 as month
    from dbt_swift_transactions.dim_shipment_type_july

    union all 

    select *,
            8 as month
    from dbt_swift_transactions.dim_shipment_type_august

    union all 

    select *,
            9 as month
    from dbt_swift_transactions.dim_shipment_type_september

    union all 

    select *,
            10 as month
    from dbt_swift_transactions.dim_shipment_type_october

    union all 

    select *,
            11 as month
    from dbt_swift_transactions.dim_shipment_type_november
)

select 
     avg(case when d.weight_in_kg * u.price_per_kg = list_price then 1 else 0 end) as list_price_calc_is_same_as_fct_shipments
from shipment_types d
left join union_stategy_price u 
on (d.shipment_type_id, d.month) = (u.shipment_type_id, u.month)
