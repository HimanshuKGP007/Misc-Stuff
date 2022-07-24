

#   WITH user_reach AS (
#   SELECT user_id, EXTRACT(HOUR FROM TIMESTAMP(TIMESTAMP_MICROS(event_time))) AS event_Hour
#   FROM `tatasky.adh_export.hp_temp_poc6`
#   order by 1
# )
# Will be using the above for DayPart distribution - Counter for DayPart clicks
# Average gap btw viewing the ads
  
  SELECT user_id,
         max(DATE(TIMESTAMP_MICROS(event_time))) as Max_Date,
         min(DATE(TIMESTAMP_MICROS(event_time))) as Min_Date,
         EXTRACT(HOUR FROM TIMESTAMP(MAX(TIMESTAMP_MICROS(event_time)))) AS last_touchPoint_Hour,
         EXTRACT(HOUR FROM TIMESTAMP(MIN(TIMESTAMP_MICROS(event_time)))) AS first_touchPoint_Hour,
         DATE_DIFF(max(DATE(TIMESTAMP_MICROS(event_time))), min(DATE(TIMESTAMP_MICROS(event_time))), DAY) AS DateDiff
         
  FROM `tatasky.adh_export.hp_temp_poc6`
  GROUP BY 1
  order by 


