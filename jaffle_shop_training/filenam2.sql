select
    order_id,
    {{ get_payment_method_amounts2() }}

from {{ ref("stg_stripe__payment") }}

group by 1


{{ pivot_amounts('order_id', 'payment_method') }}