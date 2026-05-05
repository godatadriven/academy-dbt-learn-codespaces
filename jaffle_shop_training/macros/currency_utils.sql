{% macro transform_integer_to_currency_decimal(amount_currency) -%}

    {{amount_currency}}/100::numeric(16,2)

{%- endmacro %}

{% macro calculate_amount_by_status(model_name, status_name, amount_column) -%}

    {%- set status_values = dbt_utils.get_column_values(table=ref(model_name), column=status_name) -%}

    {% for status in status_values -%}
        sum(case when {{ status_name }} = '{{ status }}' then {{ amount_column }} else 0.0 end) as {{ status }}_amount{% if not loop.last %}, {% endif %}
    {% endfor %}

{%- endmacro %}
