select * from {{ source('stripe', 'payments') }}
where amount < 0