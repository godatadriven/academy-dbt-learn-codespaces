
{% macro get_values_from_model(model_name, column_name) -%}

    {% set values = dbt_utils.get_column_values(table=ref(model_name), column=column_name) %}

    {{ return(values) }}

{% endmacro %}


{% macro build_case_when_for_each_status(amount_name, status_column_name, status_list) -%}

    {% for status in status_list -%}
        sum(case when {{ status_column_name }} = '{{ status }}' then {{ amount_name }} else 0 end) as {{ status }}_amount{% if not loop.last %}, {% endif %}
    {% endfor %}

{% endmacro %}