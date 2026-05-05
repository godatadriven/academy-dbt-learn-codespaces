{% macro get_payment_method_amounts2() -%}
    {%- set payment_methods = dbt_utils.get_column_values(
        table=ref('stg_stripe__payment'),
        column='payment_method'
    ) -%}

    {%- for payment_method in payment_methods %}
        sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount{{ "," if not loop.last }}
    {%- endfor -%}
{%- endmacro %}