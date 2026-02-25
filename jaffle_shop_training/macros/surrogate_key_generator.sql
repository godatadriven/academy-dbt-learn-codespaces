{% macro surrogate_key_generator(col_1,col_2)%}

md5({{col_1}} || {{col_2}})

{% endmacro %}