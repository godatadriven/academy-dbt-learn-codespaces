select * from analytics.dbt_ssundaram.dim_customers;

select * from {{ source('jaffle_shop', 'orders') }};


select *
from all_values
where value_field not in (
    'placed','shipped','completed','returned'
)
;

select * from raw.stripe.payment

select status, sum(amount) from raw.stripe.payment group by 1 order by 1

select _batched_at, sum(amount) from raw.stripe.payment group by 1 order by 1 desc

select * from fct_orders

select order_status, sum(amount), sum(amount_excl_returns)
from fct_orders
group by 1 order by 1

select  sum(amount), sum(amount_excl_returns)
from fct_orders
 order by 1


    select
        *
    from {{ ref('stg_jaffle_shop__orders') }}

select * from dim_customers

select sum(lifetime_value) from dim_customers