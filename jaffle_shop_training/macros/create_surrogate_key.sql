
{% macro create_surrogate_key(column_name_1, column_name_2) %}

md5 ( concat ( coalesce({{column_name_1}}, 'null'), coalesce({{column_name_2}}, 'null') ) )

{%- endmacro -%}


{% macro create_surrogate_key_hash(column_name_1, column_name_2) %}

hash ( concat ( coalesce({{column_name_1}}, 'null'), coalesce({{column_name_2}}, 'null') ) )

{%- endmacro -%}
