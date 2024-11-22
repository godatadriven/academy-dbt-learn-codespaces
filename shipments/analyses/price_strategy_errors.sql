select 
    transaction_id,
    price_per_kg as strategy_price_per_kg,
    (list_price / shipment_weight_kgs) as actual_price_per_kg
from {{ref('fct_shipments')}}
where price_per_kg <> round((list_price / shipment_weight_kgs),0)