WITH TRIPS as (
    select 
    ride_id,
    rideable_type,
    DATE(TO_TIMESTAMP(REPLACE(started_at, '"', ''))) AS TRIP_DATE,
    START_STATIO_ID AS START_STATION_ID,
    END_STATION_ID,
    MEMBER_CSUAL AS MEMBER_CASUAL,
    TIMESTAMPDIFF(SECOND, TO_TIMESTAMP(REPLACE(started_at, '"', '')), TO_TIMESTAMP(REPLACE(ended_at, '"', ''))) AS TRIP_DURATION_SECONDS
    from
    {{ source('demo', 'bike') }}

    limit 10
)

select * from TRIPS