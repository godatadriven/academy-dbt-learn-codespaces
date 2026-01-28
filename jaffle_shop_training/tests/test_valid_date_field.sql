select order_date
from {{ ref("stg_jaffle_shop__orders")}}
where order_date > current_date()