 """Run Question 1 first: later questions use the `perf_clean` view it creates."""

 """Question 1. Build a deduplicated view: keep one row per date + campaign + region (the lowest record_id) using ROW_NUMBER."""

    WITH perf AS 
        (SELECT
            date,
            campaign_id,
            region,
            dense_rank() OVER (PARTITION BY date, campaign_id, region order by region) AS RK
        FROM `my-sql-project-513018.campaign_data.daily_performance`)
    SELECT 
        *, 
        count( DISTINCT RK) from perf 
        group by 1,2,3,4