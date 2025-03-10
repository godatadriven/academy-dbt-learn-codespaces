with bridge_table as (
    SELECT
        cust_id as customer_id,
        cust_id_business_held_confirmed as business_id
    FROM dbt_swift_production.fct_shipments
    GROUP BY customer_id, business_id
),

dim_businesses as (
    select * from dbt_swift_production.dim_businesses
),

dim_customers as (
    select * from dbt_swift_production.dim_customers
),

num_custs_per_bus as (
    SELECT
        dim_businesses.business_id,
        COUNT(DISTINCT bridge_table.customer_id) AS num_customers
    FROM bridge_table
    JOIN dim_businesses ON bridge_table.business_id = dim_businesses.business_id
    GROUP BY dim_businesses.business_id
),

num_bus_per_cus as (
    SELECT
        dim_customers.customer_id,
        COUNT(DISTINCT bridge_table.business_id) AS num_businesses
    FROM bridge_table
    JOIN dim_customers ON bridge_table.customer_id = dim_customers.customer_id
    GROUP BY dim_customers.customer_id
)

select 
    avg(num_businesses) as avg_num_bus_per_cust,
    avg(num_customers) as avg_num_cust_per_bus
from num_bus_per_cus
left join num_custs_per_bus