with source as (
      select * from {{ source('swift_transactions', 'shipments') }}
),
renamed as (
    select
        id,
        locatie_gegevens_cc,
        zenddatum__c,
        status,
        cust_id,
        invoicing_f_code_initialized_confirmed,
        cust_id_business_held_confirmed,
        ontvangstdatum,
        aanmaakdatum,
        locatie_gegevens_continent,
        vehicle_id,
        invoicing_f_code_paid_date_confirmed,
        z_list_price,
        wgtkg_123x,
        dimension_package_for_shipment,
        driver_id,
        invoicing_f_code_createddate_confirmed,
        invoicing_f_code_status,
        shipment_type_id,
        invoicing_f_code_initialized_unconfirmed,
        cust_id_business_held_hetoudesysteem,

    from source
)
select * from renamed
  