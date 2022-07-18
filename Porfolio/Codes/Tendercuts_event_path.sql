WITH ref AS (SELECT 
event_name, device. advertising_id as unique_user
from tendercuts-d9c26.analytics_150782945.events_20210421
group by 2,1
order by 2 desc)
 
SELECT ref.unique_user , STRING_AGG(ref.event_name, ' > ') AS event_path
FROM ref 
GROUP BY ref.unique_user;