SELECT  
  format_date("%G", date) AS Year,
  format_date("%B",date) AS Month,
  sum(spend) AS Cost
  --format_date("%B",max(date)) AS End_Month,
  --min(date) AS End_Date,
  --max(date) AS End_Date,
  --date_diff(max(date),min(date),DAY) AS No_of_days,
FROM `my-sql-project-513018.campaign_data.daily_performance`
where format_date("%G", date) = "2026"
Group by 1,2
order by format_date("%G", date)
