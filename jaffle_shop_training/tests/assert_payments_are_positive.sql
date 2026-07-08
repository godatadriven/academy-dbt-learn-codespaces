select *
from {{source('jaffle_shop', 'payments')}}
where payments > 0 
