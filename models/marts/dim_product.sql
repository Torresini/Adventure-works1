with
    dim_products as (
        select *
            , {{ dbt_utils.generate_surrogate_key(['productid']) }} as sk_productid 
        from {{ ref('stg_sap_adw__products') }}
    )

select *
from dim_products