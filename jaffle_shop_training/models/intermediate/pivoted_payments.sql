{# {% set payment_methods = dbt_utils.get_column_values(table=ref('stg_payments'), column='payment_method') -%} #}

{% set payment_methods = ['bank_transfer', 'credit_card', 'coupon', 'gift_card'] -%}

with payments as (
    select * from {{ ref('stg_stripe_payments') }}
),

pivoted as (
    select
        order_id,

        {% for payment_method in payment_methods -%}

        sum(case when payment_method = '{{ payment_method }}' then payment_amount else 0 end) as {{ payment_method }}_amount
        
        {%- if not loop.last -%}
        ,
        {% endif -%}
        
        {%- endfor %}
    
    from payments
    group by 1
)

select * from pivoted