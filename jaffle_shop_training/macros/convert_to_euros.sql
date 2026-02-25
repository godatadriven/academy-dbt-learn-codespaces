{% macro convert_to_euros(column_name,decimal_places=2) -%}

{{ column_name }}/100::numeric(16,{{ decimal_places }})

{%- endmacro -%}