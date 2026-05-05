with 

source as (

    select * from {{ source('jaffle_shop', 'customers') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['first_name', 'last_name']) }} as name_sk,
        id as customer_id,
        first_name,
        last_name
    from source

)

select * from renamed