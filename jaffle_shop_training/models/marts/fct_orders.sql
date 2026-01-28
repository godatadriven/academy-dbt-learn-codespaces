with
    payments as (

        select *

        from {{ ref('stg_stripe__payments') }}
        
        )
 select * from stg_stripe__payments