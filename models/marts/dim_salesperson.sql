with
    dim_salesperson as (
        select *
            , {{ dbt_utils.generate_surrogate_key(['businessentityid']) }} as sk_businessentityid 
        from {{ ref('stg_sap_adw__salesperson') }}
    )

select *
from dim_salesperson