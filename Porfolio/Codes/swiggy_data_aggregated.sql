create table brand as
  (select device_id_md5
   from 
     ((select device_id_md5
   from adh.dv360_youtube_impressions_rdid where (insertion_order_id = 19621942 or insertion_order_id = 19621943))
   union all 
   (select device_id_md5 from adh.dv360_dt_impressions_rdid where event.dv360_insertion_order_id = 19621942 or event.dv360_insertion_order_id = 19621943)) a group by 1
   );