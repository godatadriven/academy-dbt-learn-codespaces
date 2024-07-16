{% macro cents_to_dollars(column, scale=2) %}
{{ column }}/100::numeric(16, {{ scale }})
{% endmacro %}