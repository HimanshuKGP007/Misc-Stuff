WITH user_reach AS (
  SELECT user_id,
        DATE_DIFF(DATE(TIMESTAMP_MICROS(max(event.event_Time)),"Asia/Kolkata"),DATE(TIMESTAMP_MICROS(min(event.event_Time)),"Asia/Kolkata"), DAY) AS days_span,
         count(*) AS num_views
  FROM adh.cm_dt_impressions
  GROUP BY user_id
),
converted_users AS
(
  SELECT
  user_id,
  1 as is_converted
  FROM
  adh.cm_dt_activities_attributed
  WHERE 
event.activity_id = 7310912 or event.activity_id = 7324390 or event.activity_id = 8465924 or event.activity_id = 8465681  GROUP BY user_id
),
combined_table AS
(
  SELECT * FROM user_reach
  LEFT JOIN
  converted_users USING (user_id)
)
SELECT
  "days_span" = case when days_span between 0 and 5 then '0 - 5'
        when days_span between 5 and 10 then '5 - 10'
        when days_span between 10 and 15 then '0 - 5'
        when days_span between 15 and 20 then '0 - 5'
        when days_span between 20 and 25 then '0 - 5'
        else '25+'
        END,
  IF(num_views <= 10, CAST(num_views AS string), "10+") AS num_views,
  COUNT(distinct(user_id)) AS unique_users,
  sum(is_converted) AS converted_users

FROM combined_table
GROUP BY 1, 2
ORDER BY 3 DESC