WITH user_hour AS (
  SELECT user_id, EXTRACT(HOUR FROM TIMESTAMP(TIMESTAMP_MICROS(event_time))) AS event_Hour
  FROM `tatasky.adh_export.hp_temp_poc6`
  order by 1
)

# Will be using the above for DayPart distribution - Counter for DayPart clicks
# Still need to decide the hours for sorting the DayPart Data - Just taken an assumption to get some output values
#
# Idea - 1: Observe the gradients in consecutive time_gap_between_clicks
# Idea - 2: Standard Deviation of time_gap_between_clicks for each user
  
  SELECT user_id,
         min(DATE(TIMESTAMP_MICROS(event_time))) as first_Date,
         max(DATE(TIMESTAMP_MICROS(event_time))) as last_Date,
         EXTRACT(HOUR FROM TIMESTAMP(MIN(TIMESTAMP_MICROS(event_time)))) AS firstDay_touchPoint_Hour,
         EXTRACT(HOUR FROM TIMESTAMP(MAX(TIMESTAMP_MICROS(event_time)))) AS lastDay_touchPoint_Hour,
         DATE_DIFF(max(DATE(TIMESTAMP_MICROS(event_time))), min(DATE(TIMESTAMP_MICROS(event_time))), DAY) AS DateDiff,
         (SELECT COUNTIF(event_Hour < 12) FROM user_hour WHERE user_hour.user_id = a.user_id ) as Morning_Clicks, 
         (SELECT COUNTIF(event_Hour >= 12 AND event_Hour <= 18)FROM user_hour WHERE user_hour.user_id = a.user_id) AS Afternoon_Clicks, 
         (SELECT COUNTIF(event_Hour > 18)FROM user_hour WHERE user_hour.user_id = a.user_id) AS Evening_Clicks,    
         COUNT(event_time) as Total_Clicks, 
         DATE_DIFF(max(DATE(TIMESTAMP_MICROS(event_time))), min(DATE(TIMESTAMP_MICROS(event_time))), DAY)/COUNT(event_time)
         as average_time_gap_between_clicks_days

  FROM `tatasky.adh_export.hp_temp_poc6`a
  GROUP BY 1
  order by 1 desc