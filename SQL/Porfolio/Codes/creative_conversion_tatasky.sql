WITH ref as (
    SELECT user_id, t2.event.creative_version as Creative_Version,
      t2.event.dv360_creative_id as Creative_id
FROM adh.cm_dt_activities_attributed t1
LEFT JOIN adh.cm_dt_activities t2 USING (user_id)
)

SELECT count(distinct(ref.user_id)), ref.Creative_id, ref.Creative_Version from ref group by 2,3


select count(distinct(user_id)) as Reach,
       event.creative_version as Creative_Version,
       event.dv360_creative_id,
       sum(event.total_conversions)
from adh.cm_dt_activities_attributed
group by 2, 3
