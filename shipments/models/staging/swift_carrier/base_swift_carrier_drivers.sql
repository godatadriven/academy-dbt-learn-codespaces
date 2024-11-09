with source as (
      select * from {{ source('swift_carrier', 'drivers') }}
),
renamed as (
    select
        driver_id,
        driver as driver_full_name,
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
  