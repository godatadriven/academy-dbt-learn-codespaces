{{
    config(
        severity='error'
    )
}}

select payment_id, payment_amount
from {{ ref("stg_stripe__payment") }}
where payment_amount < 0