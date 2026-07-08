with 

source as (

    select * from {{ source('jaffle_shop', 'customers') }}

),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name

    from source

)

select *,
 {{ dbt_utils.generate_surrogate_key(['first_name', 'last_name']) }} as name_sk

from renamed