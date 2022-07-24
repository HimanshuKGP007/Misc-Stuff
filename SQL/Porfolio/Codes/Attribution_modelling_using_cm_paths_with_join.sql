/* Substitute *_paths for the specific paths table that you want to query. */
WITH ref_id as (
SELECT
  (SELECT attributed_event_metadata.placement_id
  FROM (
    SELECT
      AS STRUCT attributed_event.placement_id,
      ROW_NUMBER() OVER(ORDER BY attributed_event.event_time ASC) AS rank
    FROM
      UNNEST(t.path.events) AS attributed_event 
    WHERE
      attributed_event.event_type != "FLOODLIGHT"
      AND attributed_event.event_time < conversion_event.event_time
      AND attributed_event.event_time > (
      SELECT
        IFNULL( (
          SELECT
            MAX(prev_conversion_event.event_time) AS event_time 
          FROM
            UNNEST(t.path.events) AS prev_conversion_event
          WHERE
            prev_conversion_event.event_type = "FLOODLIGHT"
            AND prev_conversion_event.event_time < conversion_event.event_time),
          0)) ) AS attributed_event_metadata
  WHERE
    attributed_event_metadata.rank = 1
  ) AS placement_id,
  COUNT(*) AS credit
FROM
adh.cm_paths AS t,
UNNEST(t.path.events) AS conversion_event
WHERE
  conversion_event.event_type = "FLOODLIGHT"
GROUP BY
  placement_id
HAVING
  placement_id IS NOT NULL
ORDER BY
  credit DESC
), 
ref_name as (select placement_id, placement from adh.cm_dt_placement),
combined_table as (select * from ref_id left join ref_name using(placement_id))
SELECT *, 'first_touch' AS attribution_model from combined_table order by credit desc