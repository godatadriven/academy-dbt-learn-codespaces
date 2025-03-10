with source as (
      select * from {{ source('swift_carrier', 'vehicles') }}
),
renamed as (
    select
        vehicle_id,
        vehicle_type,
        manufacturer,
        model,
        license_plate,
        fuel_type,
        status as vehicle_status,
        purchase_date,
        last_service_date,
        mileage,
        location_id,
        ownership as vehicle_ownership,
        gps_tracking_enabled

    from source
)
select * from renamed
  