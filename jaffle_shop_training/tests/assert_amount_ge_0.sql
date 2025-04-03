select * 
from {{ ref('stg_stripe__payments') }}
where payment_amount < 0