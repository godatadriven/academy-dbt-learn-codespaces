--For the test to pass the query has to return 0 rows

select *
from {{ source('jaffle_shop','orders')}}
where order_date > current_date()