-- https://jinja.palletsprojects.com/en/stable/templates/
 
-- * Use a set at the top of the file to make payment_methods
-- * Whitespace control in the compiled output
-- ** Remove the trailing comma
-- *** can we ask SQL what the distinct values are? -- YES but you need a package 
-- **** make this into a macro
 


select 
    order_id,
{% for payment_method in payment_methods %}
    sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount{% if not loop.last %},{% endif %}
{% endfor %}
from {{ ref("stg_stripe__payment") }}
group by 1