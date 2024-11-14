with customers as (
    select * from {{ref("base_swift_base_customers") }}
),
create_primary_key as (
    select
    {{ dbt_utils.generate_surrogate_key(['customer_id','first_name','last_name','city','email'])}} as customer_id_sk,*
    from customers
)

select * from create_primary_key
order by customer_id_sk