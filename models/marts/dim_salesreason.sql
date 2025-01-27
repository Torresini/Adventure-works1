with
    stg_salesreason as (
        select *
        from {{ ref("stg_sap_adw__salesreason") }}
    )

    , tables as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_salesreason.salesreasonid']) }} as sk_salesreason
            
            , stg_salesreason.salesreasonid
            , stg_salesreason.name
            , stg_salesreason.reasontype

        from stg_salesreason
        
    )

select *
from tables