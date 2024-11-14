{% macro convert_cents_to_dollars(column_name) %}

({{ column_name }}/100)::numeric(16, 2)

{% endmacro %}