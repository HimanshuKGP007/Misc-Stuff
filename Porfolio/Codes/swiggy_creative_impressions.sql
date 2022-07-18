select c.campaign_name,
imp.ad_group_creative_id,
count(distinct( imp.user_id)) as reach,
# count(imp.user_id)/count(distinct(imp.user_id)) as avg_frq,
count(impression_id) as impressions
from
  adh.google_ads_impressions imp
  left join 
    adh.google_ads_campaign c
    on imp.campaign_id = c.campaign_id
    
    left join
      adh.google_ads_creative ac
      on imp.ad_group_creative_id = ac.creative_id


 group by 1,2
