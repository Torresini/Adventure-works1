with 

source as (

    select * from {{ source('sap_adw', 'salesorderheadersalesreason') }}

),

renamed as (

    select *

    from source

)

select * from renamed
