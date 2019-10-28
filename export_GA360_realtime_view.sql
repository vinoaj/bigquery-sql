#standardSQL
#find the highest index custom dimension
SELECT MAX((SELECT MAX(index) FROM UNNEST(hits), UNNEST(customDimensions))) AS max_cd_ix
FROM `XXXXXX.158895650.ga_sessions_20180912` 
LIMIT 100


#legacySQL
SELECT visitId
  , visitNumber
  , visitStartTime
  , date
  , totals.*
  , hits.hitNumber
  , trafficSource.*
  , device.*
  , geoNetwork.*
  , hits.time
  , hits.isSecure
  , hits.isInteraction
  , hits.isEntrance
  , hits.isExit
  , hits.referer
  , hits.type
  , hits.dataSource
  , hits.page.*
  , hits.transaction.*
  , hits.item.*
  , hits.contentInfo.*
  , hits.appInfo.*
  , hits.exceptionInfo.*
  , hits.eventInfo.*
  , hits.refund.*
  , hits.eCommerceAction.*
  , hits.experiment.*
  , hits.publisher.*
  , hits.social.*
  , hits.latencyTracking.*
  , hits.sourcePropertyInfo.*
  , hits.contentGroup.*
  , MAX(IF(hits.customDimensions.index=1, hits.customDimensions.value, NULL)) WITHIN hits AS cd01
  , MAX(IF(hits.customDimensions.index=2, hits.customDimensions.value, NULL)) WITHIN hits AS cd02
  , MAX(IF(hits.customDimensions.index=3, hits.customDimensions.value, NULL)) WITHIN hits AS cd03
  , MAX(IF(hits.customDimensions.index=4, hits.customDimensions.value, NULL)) WITHIN hits AS cd04
  , MAX(IF(hits.customDimensions.index=5, hits.customDimensions.value, NULL)) WITHIN hits AS cd05
  , MAX(IF(hits.customDimensions.index=6, hits.customDimensions.value, NULL)) WITHIN hits AS cd06
  , MAX(IF(hits.customDimensions.index=7, hits.customDimensions.value, NULL)) WITHIN hits AS cd07
  , MAX(IF(hits.customDimensions.index=8, hits.customDimensions.value, NULL)) WITHIN hits AS cd08
  , MAX(IF(hits.customDimensions.index=9, hits.customDimensions.value, NULL)) WITHIN hits AS cd09
  , MAX(IF(hits.customDimensions.index=10, hits.customDimensions.value, NULL)) WITHIN hits AS cd10
  , MAX(IF(hits.customDimensions.index=11, hits.customDimensions.value, NULL)) WITHIN hits AS cd11
  , MAX(IF(hits.customDimensions.index=12, hits.customDimensions.value, NULL)) WITHIN hits AS cd12
  , MAX(IF(hits.customDimensions.index=13, hits.customDimensions.value, NULL)) WITHIN hits AS cd13
  , MAX(IF(hits.customDimensions.index=14, hits.customDimensions.value, NULL)) WITHIN hits AS cd14
  , MAX(IF(hits.customDimensions.index=15, hits.customDimensions.value, NULL)) WITHIN hits AS cd15
  , MAX(IF(hits.customDimensions.index=16, hits.customDimensions.value, NULL)) WITHIN hits AS cd16
  , MAX(IF(hits.customDimensions.index=17, hits.customDimensions.value, NULL)) WITHIN hits AS cd17
  , MAX(IF(hits.customDimensions.index=18, hits.customDimensions.value, NULL)) WITHIN hits AS cd18
  , MAX(IF(hits.customDimensions.index=19, hits.customDimensions.value, NULL)) WITHIN hits AS cd19
  , MAX(IF(hits.customDimensions.index=20, hits.customDimensions.value, NULL)) WITHIN hits AS cd20
  , MAX(IF(hits.customDimensions.index=21, hits.customDimensions.value, NULL)) WITHIN hits AS cd21
  , MAX(IF(hits.customDimensions.index=22, hits.customDimensions.value, NULL)) WITHIN hits AS cd22
  , MAX(IF(hits.customDimensions.index=23, hits.customDimensions.value, NULL)) WITHIN hits AS cd23
  , MAX(IF(hits.customDimensions.index=24, hits.customDimensions.value, NULL)) WITHIN hits AS cd24
  , MAX(IF(hits.customDimensions.index=25, hits.customDimensions.value, NULL)) WITHIN hits AS cd25
  , MAX(IF(hits.customDimensions.index=26, hits.customDimensions.value, NULL)) WITHIN hits AS cd26
  , MAX(IF(hits.customDimensions.index=27, hits.customDimensions.value, NULL)) WITHIN hits AS cd27
  , MAX(IF(hits.customDimensions.index=28, hits.customDimensions.value, NULL)) WITHIN hits AS cd28
  , MAX(IF(hits.customDimensions.index=29, hits.customDimensions.value, NULL)) WITHIN hits AS cd29
  , MAX(IF(hits.customDimensions.index=30, hits.customDimensions.value, NULL)) WITHIN hits AS cd30
  , fullVisitorId
  , userId
  , clientId
  , channelGrouping
  , socialEngagementType
  , exportTimeUsec
  , exportKey
  , visitKey
FROM [XXXXXX.ga_realtime_sessions_view_20180914] 
ORDER BY visitId, hits.hitNumber ASC


#standardSQL
#count number of instances of custom dimensions
WITH nested_cd_data AS (
  SELECT visitId
  , hitNumber
  , (SELECT ARRAY_AGG(index) FROM UNNEST(hits), UNNEST(customDimensions)) AS cd_ixs
  FROM `XXXXXX.XXXXXX.ga_sessions_20180912`, UNNEST(hits)
)

SELECT cd_ix, COUNT(cd_ix) AS count
FROM nested_cd_data, UNNEST(cd_ixs) AS cd_ix
GROUP BY cd_ix
ORDER BY cd_ix ASC


#standardSQL
#find the highest index custom dimension
SELECT MAX((SELECT MAX(index) FROM UNNEST(hits), UNNEST(customDimensions))) AS max_cd_ix
FROM `XXXXXX.XXXXXX.ga_sessions_20180912` 
LIMIT 100