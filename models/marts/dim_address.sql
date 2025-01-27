with
    stg_address as (
        select *
        from {{ ref("stg_sap_adw__address") }}
    )

    , stg_stateprovince as (
        select *
        from {{ ref("stg_sap_adw__stateprovince") }}
    )

    , stg_countryregion as (
        select *
        from {{ ref("stg_sap_adw__countryregion") }}
    )


    , tables as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_address.addressid']) }} as sk_address
            , stg_address.addressid
            , stg_address.addressline1
            , stg_address.addressline2
            , stg_address.city
            , stg_address.stateprovinceid
            , stg_address.postalcode
            , stg_stateprovince.stateprovinceid as stateprovinceid2
            , stg_stateprovince.stateprovincecode
            --, stg_stateprovince.countryregioncode
            , stg_stateprovince.name
            , stg_stateprovince.territoryid
            , stg_countryregion.countryregioncode
            , stg_countryregion.contryregionname


        from stg_address
        left join stg_stateprovince on stg_stateprovince.stateprovinceid = stg_address.stateprovinceid
        left join stg_countryregion on stg_countryregion.countryregioncode = stg_stateprovince.countryregioncode
    )

select *
from tables