with source as (
      select * from {{ source('swift_transactions', 'shipments') }}
),
renamed as (
    select
        id as transaction_id,
        locatie_gegevens_cc as location_code,
        TO_TIMESTAMP(zenddatum__c / 1000) as send_date,
        status as transaction_status,
        cust_id as customer_id,
        invoicing_f_code_initialized_confirmed as invoice_id,
        cust_id_business_held_confirmed as customer_id_business_held_confirmed,
        TO_TIMESTAMP(ontvangstdatum / 1000) as receive_date,
        TO_TIMESTAMP(aanmaakdatum / 1000) as label_creation_date,
        locatie_gegevens_continent as location_region_code,
        vehicle_id,
        invoicing_f_code_paid_date_confirmed,
        z_list_price as list_price,
        ROUND(CAST(REPLACE(wgtkg_123x, ' ', '.') AS FLOAT),3) as shipment_weight_kgs,
        dimension_package_for_shipment as package_dimension,
        driver_id,
        TO_TIMESTAMP(invoicing_f_code_createddate_confirmed / 1000) as invoice_date,
        invoicing_f_code_status as invoice_status,
        shipment_type_id,
        invoicing_f_code_initialized_unconfirmed as incomplete_invoice_id,
        cust_id_business_held_hetoudesysteem as customer_business_id

    from source
)
select * from renamed
  