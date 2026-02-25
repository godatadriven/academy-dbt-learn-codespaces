{% macro convert_to_euros(column_name, decimal_place=2) -%}

{{ column_name }} /100::numeric(16, {{ decimal_place }})

{%- endmacro %}