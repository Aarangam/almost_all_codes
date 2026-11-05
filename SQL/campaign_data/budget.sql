SELECT
  campaign_name Campaign,
  channel AS Channel,
  platform AS Platform,
  objective AS Objective,
  start_date AS SD,
  end_date AS ED,
  date_diff(end_date, start_date, DAY) AS No_of_days,
  sum(daily_budget) AS Daily_Budget,
  (sum(daily_budget) * date_diff(end_date, start_date, DAY)) AS Budget
FROM
  `my-sql-project-513018.campaign_data.campaigns`
GROUP BY
  1, 2, 3, 4, 5, 6, 7