WITH daily_weather AS (
    select 
    date(TIME) as daily_weather,
    weather,
    temp,
    pressure,
    humidity,
    clouds
    from {{ source('demo', 'weather') }}
    limit 10
    ),

daily_weather_agg AS(
    select
    daily_weather,
    weather,
    round(avg(temp),2) as AVG_TEMP,
    round(avg(pressure),2) AS AVG_PRESSURE,
    round(avg(humidity),2) AS AVG_HUMIDITY,
    round(avg(clouds),2) AS AVG_CLOUDS
    from daily_weather
    group by daily_weather, weather
    qualify row_number() OVER (PARTITION BY daily_weather order by count(weather) desc) = 1
)

select 
*
from daily_weather_agg