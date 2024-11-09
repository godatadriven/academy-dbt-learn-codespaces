with source as (
      select * from {{ source('swift_carrier', 'vehicles') }}
),
renamed as (
    select
        vehicle_type,
        manufacturer,
        model,
        license_plate,
        fuel_type,
        status,
        purchase_date,
        last_service_date,
        mileage,
        location_id,
        ownership,
        gps_tracking_enabled,
        vehicle_id

    from source
)
select * from renamed
  