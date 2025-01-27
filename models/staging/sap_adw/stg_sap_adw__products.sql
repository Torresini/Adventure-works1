with 

source as (

    select * from {{ source('sap_adw', 'product') }}

),

renamed as (

    select *

    from source

)

select * from renamed
