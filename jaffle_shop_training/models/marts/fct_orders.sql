select payment_id,
        order_id,
        amount
from {{ ref('stg_stripe_data__payment') }}