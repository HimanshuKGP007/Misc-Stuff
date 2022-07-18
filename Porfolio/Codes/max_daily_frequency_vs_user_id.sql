WITH ref AS(
    SELECT  user_id, 
DATE(TIMESTAMP_MICROS(event_time)) as event_date,
     count(distinct(event_time)) as daily_frequency


FROM `tatasky.adh_export.hp_temp_poc6`a
group by 1,2
order by 1 ,2 desc)

SELECT user_id, max(daily_frequency) from ref group by user_id