with source as (
      select * from {{ source('swift_base', 'customers') }}
),
renamed as (
    select
        cust_id_ as customer_id,
        fname as first_name,
        lname as last_name,
        custst_ as street,
        cpstl_cd_2024 as postal_code,
        customerzcity_ as city,
        ccountryxcode as country_code,
        cust_email as email

    from source
)
select * from renamed