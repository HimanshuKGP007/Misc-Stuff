WITH all_impressions1 AS
(
  SELECT
    user_id,
    event.event_time AS impression,
  FROM
    adh.cm_dt_impressions
  WHERE
    user_id <> '0'
),
 
all_impressions2 AS
(
  SELECT
    user_id,
    event.event_time AS impression,
  FROM
    adh.cm_dt_impressions
  WHERE
    user_id <> '0'
)


 
SELECT 'Overall' as flag,
  COUNT(impression) AS total_impressions,
  COUNT(DISTINCT user_id) AS unique_reach,
  COUNT(impression)/COUNT(DISTINCT user_id) AS avg_frequency
FROM
  all_impressions1
GROUP BY 1
 
union all
 
SELECT 'Sub' as flag,
  COUNT(impression) AS total_impressions,
  COUNT(DISTINCT user_id) AS unique_reach,
  COUNT(impression)/COUNT(DISTINCT user_id) AS avg_frequency
FROM
  all_impressions2
GROUP BY 1
;
