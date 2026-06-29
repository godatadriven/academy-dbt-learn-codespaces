select *
from {{ source('jaffle_shop', 'orders') }}
where order_date > current_date()