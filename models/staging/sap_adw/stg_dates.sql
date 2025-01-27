{{
    config(
        materialized = "table"
    )
}}

WITH date_dimension AS (
    {{ dbt_date.get_date_dimension("1990-01-01", "2050-12-31") }}
)

, stg_dates AS (
    SELECT 
        date(date_day) AS date_day
        ,day_of_week_name
        ,month_name
        ,year_number
        ,quarter_of_year
        ,month_of_year
        
    FROM date_dimension

)

SELECT * 
FROM stg_dates
