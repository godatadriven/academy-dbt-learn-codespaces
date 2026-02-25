with 

source as (

    select * from {{ source('snapshot_example', 'customers_1') }}

),

renamed as (

    select
        student_id,
        name,
        email_address,
        phone_number,
        home_address,
        updated_at

    from source

)

select * from renamed