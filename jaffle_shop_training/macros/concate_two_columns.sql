{% macro generate_surrogate_key (column_one, column_two) %}
    md5
        (
            cast({{ column_one }} as varchar) || '|' ||  cast({{ column_two }} as varchar)
        )  as surrogate_key
{% endmacro %}
