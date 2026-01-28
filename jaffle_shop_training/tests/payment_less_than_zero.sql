-- Add a custom test -> Are any payment amounts less than 0? They shouldn’t be!

select * from {{ ref("stg_stripe__payments") }}
where amount < 0