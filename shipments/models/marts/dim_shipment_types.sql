{% set nums=[1,2,3,4,5,6,7,8,9,10,11]%}
{% set names=['january','february','march','april','may','june','july','august','september','october','november']%}

with
union_stategy_price as (
    {% for num, name in zip(nums, names) %}
        select *,
            {{num}} as month
    from {{ ref('stg_swift_transactions__dim_shipment_type_' ~ name) }}
    {% if not loop.last %}
    union all
    {% endif %}
    {% endfor %}
 )
 
select
     *
     from union_stategy_price