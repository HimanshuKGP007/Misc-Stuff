Select event.dv360_insertion_order_id,
       count(user_id), 
       count(event.impression_id)
from adh.dv360_dt_impressions
where event.dv360_insertion_order_id in (19621942, 19621943)
group by 1