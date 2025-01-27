with
    dim_creditcard as (
        select *
            , {{ dbt_utils.generate_surrogate_key(['creditcardid']) }} as sk_creditcard 
        from {{ ref('stg_sap_adw__creditcard') }}
    )

select *
from dim_creditcard