with
    stg_salesorderheader as (
        select
            salesorderid,
            revisionnumber,
            orderdate,
            duedate,
            shipdate,
            status,
            onlineorderflag,
            purchaseordernumber,
            accountnumber,
            customerid,
            salespersonid,
            territoryid,
            billtoaddressid,
            shiptoaddressid,
            shipmethodid,
            creditcardid,
            creditcardapprovalcode,
            currencyrateid,
            subtotal,
            taxamt,
            freight,
            totaldue

        from {{ ref('stg_sap_adw__salesorderheader') }}
    )

    , stg_salesorderdetail as (
        select
            salesorderid,
            salesorderdetailid,
            carriertrackingnumber,
            orderqty,
            productid,
            specialofferid,
            unitprice,
            unitpricediscount

        from {{ ref('stg_sap_adw__salesorderdetail') }}
    )

    , dim_address as (
        select *
        from {{ ref('dim_address')}}
    )

    , dim_creditcard as (
        select *
        from {{ ref('dim_creditcard')}}
    )

    , dim_customer as (
        select *
        from {{ ref('dim_customer')}}
    )

    , dim_dates as (
        select *
        from {{ ref('dim_dates')}}
    )

    , dim_product as (
        select *
        from {{ ref('dim_product')}}
    )

    --, dim_salesreason as (
        --select *
        --from {{ ref('dim_salesreason')}}
    --)

    , fct as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_salesorderheader.salesorderid']) }} as sk_salesorderid
            , stg_salesorderheader.salesorderid
            , stg_salesorderheader.revisionnumber
            , stg_salesorderheader.orderdate
            , stg_salesorderheader.duedate
            , stg_salesorderheader.shipdate
            , stg_salesorderheader.status
            , stg_salesorderheader.onlineorderflag
            , stg_salesorderheader.purchaseordernumber
            , stg_salesorderheader.accountnumber
            , stg_salesorderheader.customerid
            , stg_salesorderheader.salespersonid
            , stg_salesorderheader.territoryid
            , stg_salesorderheader.billtoaddressid
            , stg_salesorderheader.shiptoaddressid
            , stg_salesorderheader.shipmethodid
            , stg_salesorderheader.creditcardid
            , stg_salesorderheader.creditcardapprovalcode
            , stg_salesorderheader.currencyrateid
            , stg_salesorderheader.subtotal
            , stg_salesorderheader.taxamt
            , stg_salesorderheader.freight
            , stg_salesorderheader.totaldue
            --, stg_salesorderdetail.salesorderid
            , stg_salesorderdetail.salesorderdetailid
            , stg_salesorderdetail.carriertrackingnumber
            , stg_salesorderdetail.orderqty
            , stg_salesorderdetail.productid
            , stg_salesorderdetail.specialofferid
            , stg_salesorderdetail.unitprice
            , stg_salesorderdetail.unitpricediscount
            , dim_address.sk_address as fk_address
            , dim_customer.sk_customer as fk_customer
            , dim_creditcard.sk_creditcard as fk_creditcard
            , dim_dates.sk_date as fk_dates
            , dim_product.sk_productid as fk_productid
            --, dim_salesreason.sk_salesreason as fk_salesreason

        from stg_salesorderheader

        left join stg_salesorderdetail on stg_salesorderdetail.salesorderid = stg_salesorderheader.salesorderid
        left join dim_address on dim_address.addressid = stg_salesorderheader.shiptoaddressid
        left join dim_creditcard on dim_creditcard.creditcardid = stg_salesorderheader.creditcardid
        left join dim_customer on dim_customer.customerid = stg_salesorderheader.customerid
        left join dim_product on dim_product.productid = stg_salesorderdetail.productid
        --left join dim_salesreason on dim_salesreason.salesorderid = stg_salesorderheader.salesorderid
        left join dim_dates on dim_dates.date_day = stg_salesorderheader.duedate



    )           

        


select *
from fct