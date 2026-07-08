select * from {{ source('stripe', 'payment') }} 
where amount < 0