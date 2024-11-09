with source as (
      select * from {{ source('swift_carrier', 'drivers') }}
),
renamed as (
    select
        driver,
        driver_id,
        first_name,
        last_name,
        birth_date,
        license_id,
        license_expiry,
        hire_date,
        termination_date,
        email_address

    from source
)
select * from renamed
  