with source as (
      select * from {{ source('swift_base', 'customers') }}
),
renamed as (
    select
        cust_id_,
        fname,
        lname,
        custst_,
        cpstl_cd_2024,
        customerzcity_,
        ccountryxcode,
        cust_email

    from source
)
select * from renamed
  