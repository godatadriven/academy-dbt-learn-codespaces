{% macro get_payment_method_amounts() %}

    {% set get_payment_methods_query %}
        select distinct
            payment_method
        from {{ ref('stg_stripe__payment') }}
        order by 1
    {% endset %}

    {% set results = run_query(get_payment_methods_query) %}

    {% if execute %}
        {% set payment_methods = results.columns[0].values() %}
    {% else %}
        {% set payment_methods = [] %}
    {% endif %}

    {% for payment_method in payment_methods -%}
        sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount{{ "," if not loop.last }}
    {% endfor %}

{% endmacro -%}