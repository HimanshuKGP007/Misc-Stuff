WITH 
converters_t as (
    SELECT user_id, t2.event.creative_version as Creative_Version,
      t2.event.dv360_creative_id as Creative_id
FROM adh.cm_dt_activities_attributed t1
LEFT JOIN adh.cm_dt_activities t2 USING (user_id)
                ), 
reach_t as (SELECT user_id, event.creative_version as Creative_Version,
      event.dv360_creative_id as Creative_id
      FROM adh.cm_dt_activities
           )

SELECT converters_t.Creative_id, converters_t.Creative_Version, count(distinct(converters_t.user_id))
as converters, count(distinct(reach_t.user_id)) as reach
from converters_t
left join reach_t using(Creative_id)
group by 1,2