WITH ref1 AS(
WITH source1 AS (
  select user_id, event.event_time from  adh.dv360_dt_impressions
),
ref AS(
    SELECT  user_id, 
DATE(TIMESTAMP_MICROS(event_time)) as event_date,
     count(distinct(event_time)) as daily_frequency


FROM source1 a
group by 1,2
#order by 2 desc
)

SELECT user_id, max(daily_frequency) as max_daily_frequency from ref group by 1)

SELECT ref1.max_daily_frequency as daily_frequency, count(distinct(ref1.user_id)) as Number_of_Users
from ref1
group by 1
#order by 1