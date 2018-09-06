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