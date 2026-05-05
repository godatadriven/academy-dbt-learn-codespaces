{% macro get_payment_method_amounts3(group_by_column, pivot_column) -%}

    {%- set values = dbt_utils.get_column_values(
        table=ref('stg_stripe__payment'),
        column=pivot_column
    ) -%}

    select
        {{ group_by_column }}
    {%- for value in values %}
        , sum(case when {{ pivot_column }} = '{{ value }}' then amount else 0 end) as {{ value }}_amount
    {%- endfor %}

    from {{ ref("stg_stripe__payment") }}

    group by 1

{%- endmacro %}