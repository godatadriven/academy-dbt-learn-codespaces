with 

source as (

    select * from {{ source('jaffle_shop', 'customers') }}

),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name, 
       lifetime_value as customers_lifetime_value  
    from source

)

select * from renamed
