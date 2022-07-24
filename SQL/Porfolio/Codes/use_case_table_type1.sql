WITH user_hour AS (
  SELECT user_id, EXTRACT(HOUR FROM TIMESTAMP(TIMESTAMP_MICROS(event_time))) AS event_Hour
  FROM `tatasky.adh_export.hp_temp_poc6`
  order by 1
),
ref AS (
    SELECT  user_id, 
DATE(TIMESTAMP_MICROS(event_time)) as event_date,
     count(distinct(event_time)) as daily_frequency
FROM `tatasky.adh_export.hp_temp_poc6`a
group by 1,2
order by 1 ,2 desc)

# Will be using the above for DayPart distribution - Counter for DayPart clicks
# Still need to decide the hours for sorting the DayPart Data
# Issue: Average gap btw viewing the ads
  
  SELECT user_id,
         min(DATE(TIMESTAMP_MICROS(event_time))) as first_Date,
         max(DATE(TIMESTAMP_MICROS(event_time))) as last_Date,
         EXTRACT(HOUR FROM TIMESTAMP(MIN(TIMESTAMP_MICROS(event_time)))) AS firstDay_touchPoint_Hour,
         EXTRACT(HOUR FROM TIMESTAMP(MAX(TIMESTAMP_MICROS(event_time)))) AS lastDay_touchPoint_Hour,
         DATE_DIFF(max(DATE(TIMESTAMP_MICROS(event_time))), min(DATE(TIMESTAMP_MICROS(event_time))), DAY) AS DateDiff,
         (SELECT COUNTIF(event_Hour < 12) FROM user_hour WHERE user_hour.user_id = a.user_id ) as Morning_Clicks, 
         (SELECT COUNTIF(event_Hour >= 12 AND event_Hour <= 18)FROM user_hour WHERE user_hour.user_id = a.user_id) AS Afternoon_Clicks, 
         (SELECT COUNTIF(event_Hour > 18)FROM user_hour WHERE user_hour.user_id = a.user_id) AS Evening_Clicks,
         (SELECT max(daily_frequency) FROM ref WHERE ref.user_id = a.user_id) AS max_daily_frequency   
         
  FROM `tatasky.adh_export.hp_temp_poc6`a
  GROUP BY 1
  order by 1