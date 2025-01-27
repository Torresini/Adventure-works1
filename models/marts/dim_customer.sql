with

    stg_customer as (
        select *
        from {{ ref("stg_sap_adw__customer") }}
    )

    , stg_person as (
        select *
        from {{ ref("stg_sap_adw__person") }}
    )

    , stg_store as (
        select *
        from {{ ref("stg_sap_adw__store") }}
    )

    , tables as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_customer.customerid']) }} as sk_customer
            , stg_customer.customerid
            , stg_customer.personid
            , stg_customer.territoryid
            , stg_customer.storeid
            , stg_person.businessentityid
            , stg_person.firstname
            , stg_person.lastname
            , stg_person.persontype
            --, stg_store.businessentityid
            , stg_store.name
            , stg_store.salespersonid
            , stg_store.demographics

        from stg_customer
        left join stg_person on stg_person.businessentityid = stg_customer.personid
        left join stg_store on stg_store.businessentityid = stg_customer.storeid
    )

select *
from tables