select *
from {{ ref('dim_customers') }}
where number_of_orders < 0