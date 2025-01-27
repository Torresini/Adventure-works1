{{ config(materialized='table') }}

with fct_sales as (
        select *
        from {{ ref('fct_sales') }}
    )

    , dim_address as (
        select *
        from {{ ref('dim_address') }}
    )

    , person as (
        select *
        from {{ ref("stg_sap_adw__person")}}
    )

select
    SUM(fct_sales.subtotal) AS total_vendas
    , SUM(fct_sales.subtotal) / COUNT(DISTINCT fct_sales.salesorderid) AS ticket_medio
    , SUM(fct_sales.subtotal) / SUM(fct_sales.orderqty) AS valor_medio_produto
    , AVG(fct_sales.subtotal) AS valor_medio_por_pedido
    , fct_sales.salespersonid
    , dim_address.contryregionname
        
from fct_sales
    left join dim_address on fct_sales.billtoaddressid = dim_address.addressid
    left join person on fct_sales.salespersonid = person.businessentityid

group by fct_sales.salespersonid, dim_address.contryregionname



--select *
--from tables