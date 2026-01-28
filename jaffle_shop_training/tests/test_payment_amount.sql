{{
    config(
        severity='error'
    )
}}

select payment_id, amount
from {{ ref("stg_stripe__payment") }}
where amount < 0