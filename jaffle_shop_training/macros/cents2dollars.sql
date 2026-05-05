{% macro cents2dollars(column_name) -%}

{{ column_name }}/100

{%- endmacro %}
