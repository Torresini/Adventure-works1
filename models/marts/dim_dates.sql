{{
    config(
        materialized = "table"
    )
}}

WITH stg_dates AS (
    SELECT * FROM {{ ref('stg_dates') }}
)

SELECT 
   {{ dbt_utils.generate_surrogate_key(['date_day']) }} as sk_date
    , date_day
    , day_of_week_name
    , month_name
    , year_number
    , quarter_of_year
    , month_of_year
FROM stg_dates
