#standardSQL
SELECT 
    (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'eventCategory') AS eventCategory
  , (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'eventAction') AS eventAction
  , (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'eventLabel') AS eventLabel
  -- , (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'eventValue') AS eventValue
  , COUNT((SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'eventCategory')) AS count
FROM 
  `project-id.dataset-name.events_*` AS t
WHERE 
  _TABLE_SUFFIX BETWEEN '20180701' AND '20180905'
  AND event_name = 'event'
GROUP BY 
    eventCategory
    , eventAction
    , eventLabel
    -- , eventValue
ORDER BY 
  eventCategory ASC 
  , eventAction ASC
  -- , eventValue ASC
LIMIT 1000



#standardSQL
WITH event_params_unnested AS (
  SELECT 
    (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'eventCategory') AS eventCategory,
    (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'eventAction') AS eventAction,
    (SELECT (value.string_value) FROM UNNEST(event_params) WHERE key = 'eventLabel') AS eventLabel
  FROM 
    `lifebuddi-ver2.analytics_181913311.events_*` AS t
  WHERE 
    _TABLE_SUFFIX BETWEEN '20180701' AND '20180906'
    AND event_name = 'event'
  LIMIT 1000
)

SELECT 
  eventCategory
  , eventAction
  , ARRAY_TO_STRING(ARRAY_AGG(DISTINCT(IFNULL(eventLabel, ""))), "\r\n") AS eventLabels
  , COUNT(eventCategory) AS count
FROM event_params_unnested
GROUP BY eventCategory, eventAction