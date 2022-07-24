WITH user_reach AS (
  SELECT user_id,
        DATE_DIFF(DATE(TIMESTAMP_MICROS(max(event.event_Time)),"Asia/Kolkata"),DATE(TIMESTAMP_MICROS(min(event.event_Time))
          ,"Asia/Kolkata"), DAY) AS days_span,
         count(*) AS num_views
  FROM adh.cm_dt_impressions
  GROUP BY user_id
),
converted_users AS
(
  SELECT
  user_id
  FROM
  adh.cm_dt_activities_attributed
  WHERE 
  event.activity_id = @box_sale_activity_id
),
combined_table AS
(
  SELECT * FROM user_reach
  LEFT JOIN
  converted_users USING (user_id)
)
SELECT
  IF(days_span <= 20, CAST(days_span AS string), "20+") AS days_span,
  IF(num_views <= 10, CAST(num_views AS string), "10+") AS num_views,
  COUNT(distinct(user_id)) AS unique_users
FROM combined_table
GROUP BY 1, 2
ORDER BY 3 DESC