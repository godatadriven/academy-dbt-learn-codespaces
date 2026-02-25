{% macro create_surrogate(column1, column2) %}
md5(
    {{ column1 }} || '-' ||
    {{ column2 }}
)
{% endmacro %}