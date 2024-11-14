with source as (
      select * from {{ source('swift_transactions', 'shipments') }}
),
renamed as (
    select
        id as transaction_id,
        locatie_gegevens_cc as location_code,
        zenddatum__c as send_date,
        status as transaction_status,
        cust_id as customer_id,
        invoicing_f_code_initialized_confirmed,
        cust_id_business_held_confirmed as customer_id_business_held_confirmed,
        ontvangstdatum as receive_date,
        aanmaakdatum as label_creation_date,
        locatie_gegevens_continent as location_region_code,
        vehicle_id,
        invoicing_f_code_paid_date_confirmed,
        z_list_price as list_price,
        wgtkg_123x as shipment_weight_kgs,
        dimension_package_for_shipment as package_dimension,
        driver_id,
        invoicing_f_code_createddate_confirmed as invoice_id,
        invoicing_f_code_status as invoice_status,
        shipment_type_id,
        invoicing_f_code_initialized_unconfirmed as incomplete_invoice_id,
        cust_id_business_held_hetoudesysteem as customer_business_id

    from source
)
select * from renamed
  