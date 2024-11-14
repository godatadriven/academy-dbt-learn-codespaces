with businesses as (
    select * from {{ref("base_swift_base_businesses") }}
),
create_primary_key as (
    select
        {{ dbt_utils.generate_surrogate_key(['business_id','business_name','business_address','business_country'])}} as business_id_sk,
        *
    from businesses
)

select * from create_primary_key
--order by business_id_sk