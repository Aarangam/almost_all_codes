WITH
  campaign AS (
    SELECT
      campaign_id AS Campaign_ID,
      campaign_name AS Campaign,
      channel AS Channel,
      platform AS Platform,
      objective AS Objective,
      target_audience AS Target_Audience
    FROM
      `my-sql-project-513018.campaign_data.campaigns`
  ),
  daily AS (
    SELECT
      date AS Date,
      campaign_id AS Campaign_ID,
      region AS Region,
      sum(impressions) AS Impressions,
      sum(clicks) AS Clicks,
      sum(spend) AS Cost,
      sum(conversions) AS Conversions,
      sum(revenue) AS Revenue,
      sum(new_customers) AS New_Customers,
      sum(video_views) AS Video_Views
    FROM
      `my-sql-project-513018.campaign_data.daily_performance`
    GROUP BY
      1, 2, 3
  )
SELECT
  d.Date AS Date,
  d.Campaign_ID AS ID,
  c.Campaign AS Campaign,
  c.Channel AS Channel,
  c.Platform AS Platform,
  c.Objective AS Objective,
  c.Target_Audience AS Target_Audience,
  d.Region AS Region,
  sum(d.Impressions) AS Impressions,
  sum(d.clicks) AS Clicks,
  sum(d.Cost) AS Cost,
  sum(d.Conversions) AS Conversions,
  sum(d.Revenue) AS Revenue,
  sum(d.New_Customers) AS New_Customers,
  sum(d.Video_Views) AS Video_Views
FROM daily AS d
LEFT JOIN campaign AS c
  ON d.Campaign_ID = c.Campaign_ID
-- where date >= "2026-01-01"
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8