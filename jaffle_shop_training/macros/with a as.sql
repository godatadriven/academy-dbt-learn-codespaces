with a as
(
    select 
    customer_id
    ,first_name
    ,{{surrogate_key_generator('customer_id','first_name')}} as surrogate_key
    from {{ ref('stg_jaffle_shop__customers') }}
)
