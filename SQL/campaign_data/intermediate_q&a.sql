""" Question 1. Join performance to campaigns: total spend, revenue and ROAS per channel."""

    SELECT
        c.channel,
        round(sum(d.spend), 2) AS Spend,
        round(sum(d.revenue), 2) AS Revenue,
        round(sum(d.revenue) / sum(d.spend), 2) AS ROAS
    FROM 
        `my-sql-project-513018.campaign_data.daily_performance` d
    LEFT JOIN 
        `my-sql-project-513018.campaign_data.campaigns` c
    ON d.campaign_id = c.campaign_id
    GROUP BY 1

""" Question 2. Yearly spend by channel (use the date string to get the year)."""

    SELECT
        format_date('%Y', d.date) AS Month,
        c.channel AS Channel,
        round(sum(d.spend), 2) AS Spend
    FROM
        `my-sql-project-513018.campaign_data.daily_performance` d
    LEFT JOIN
        `my-sql-project-513018.campaign_data.campaigns` c
    ON d.campaign_id = c.campaign_id
    GROUP BY 1, 2

""" Question 3: Campaigns with total spend over $1,000,000 (use HAVING) """

    SELECT 
        c.campaign_name, 
        round(sum(d.spend),2) AS Spend
    FROM 
        `my-sql-project-513018.campaign_data.campaigns` c
    RIGHT JOIN 
        `my-sql-project-513018.campaign_data.daily_performance` d
    ON 
        d.campaign_id = c.campaign_id
    GROUP BY 
        1
    HAVING 
        sum(d.spend) > 1000000
    ORDER BY 
        sum(d.spend) DESC

""" Question 4: CPA by region, handling the NULL conversions safely (only count rows where conversions is present on both numerator and denominator)."""

    SELECT
        region AS Region,
        round(sum(spend), 2) AS Spend,
        sum(conversions) AS Conversions,
        round(safe_divide(sum(spend), sum(conversions)), 2) AS CPA
    FROM 
        `my-sql-project-513018.campaign_data.daily_performance`
    GROUP BY 
        1

""" Question 5: Replace NULL revenue with 0 using COALESCE and compare it to the raw sum."""

    SELECT 
        sum(revenue), 
        sum(coalesce(revenue, 0)), 
        COUNT(*)
    FROM 
        `my-sql-project-513018.campaign_data.daily_performance`

""" Question 6: Classify each campaign's overall ROAS as 'Great' (>=6), 'Good' (3 to <6), or 'Poor' (<3) using CASE."""

    SELECT
        c.campaign_name AS Campiagn,
        (CASE
            WHEN round(safe_divide(sum(d.revenue), sum(d.spend)), 2) >= 6 THEN "Great"
            WHEN round(safe_divide(sum(d.revenue), sum(d.spend)), 2) >= 3 AND round(safe_divide(sum(d.revenue), sum(d.spend)), 2) < 6 THEN "Good"
            WHEN round(safe_divide(sum(d.revenue), sum(d.spend)), 2) < 3 THEN "Poor"
        END) AS ROAS_Performance,
        round(safe_divide(sum(d.revenue), sum(d.spend)), 2) AS ROAS,
    FROM 
        `my-sql-project-513018.campaign_data.daily_performance` d
    LEFT JOIN 
        `my-sql-project-513018.campaign_data.campaigns` c
    ON d.campaign_id = c.campaign_id
    GROUP BY 1


""" Question 7: Monthly revenue trend for 2025 (month, revenue)."""

    SELECT 
        format_date('%m', date) AS Month,
        round(sum(revenue), 2) AS Revenue
    FROM 
        `my-sql-project-513018.campaign_data.daily_performance`
    WHERE 
        date >= "2025-01-01" AND date <"2026-01-01"
    GROUP BY 
        1
    ORDER BY 
        Month

""" Question 8: Which day of the week generates the most average daily revenue? (0 = Sunday in SQLite)"""

    SELECT
        format_date('%w', date) AS Week_num,
        format_date('%A', date) AS Week_day,
        avg(Revenue) AS Average_Revenue
    FROM
        (SELECT date, sum(revenue) AS Revenue
            FROM `my-sql-project-513018.campaign_data.daily_performance`
            GROUP BY 1)
    GROUP BY 
        1, 2
    ORDER BY 
        Average_Revenue DESC

""" Question 9: Campaigns that never ran in 2026 (anti-join with NOT EXISTS)."""

    SELECT 
        format_date("%G", d.date) AS Year, 
        c.campaign_name
    FROM 
        `my-sql-project-513018.campaign_data.campaigns` c
    RIGHT JOIN 
        `my-sql-project-513018.campaign_data.daily_performance` d
    ON d.campaign_id = c.campaign_id
    WHERE 
        d.date NOT BETWEEN "2025-01-01" AND "2025-12-31"
    ORDER BY 
        Year DESC


""" Question 10: Campaigns whose total revenue is above the average campaign total (subquery)."""



""" Question 11: Find the duplicated business keys (same date + campaign + region appearing more than once)."""



""" Question 12:  Data-quality report: rows where clicks exceed impressions, by campaign."""

    SELECT
        c.campaign_name,
        COUNT(*) AS Bad_rows
    FROM
        `my-sql-project-513018.campaign_data.campaigns` c
    RIGHT JOIN
        `my-sql-project-513018.campaign_data.daily_performance` d
    ON d.campaign_id = c.campaign_id
    WHERE
        d.clicks > d.impressions
    GROUP BY 
        1
    ORDER BY 
        Bad_rows DESC

""" Question 13: Combine two result sets with UNION ALL: total spend from Q4 2024 and Q4 2025, labeled."""

    SELECT
        "Q4 2024" AS Period,
        sum(spend) AS Spend
    FROM 
        `my-sql-project-513018.campaign_data.daily_performance`
    WHERE 
        date >= "2024-10-01" AND date <= "2024-12-31"
    UNION ALL
    SELECT
        "Q4 2025" AS Period,
        sum(spend) AS Spend
    FROM 
        `my-sql-project-513018.campaign_data.daily_performance`
    WHERE 
        date >= "2025-10-01" AND date <= "2025-12-31"


""" Question 14: Pivot: revenue per channel with one column per year (conditional aggregation)."""

    SELECT
        b.channel,
        SUM(a.Revenue_2022) AS Revenue_22,
        SUM(a.Revenue_2023)  AS Revenue_23,
        SUM(a.Revenue_2024) AS Revenue_24,
        SUM(a.Revenue_2025)  AS Revenue_25,
        SUM(a.Revenue_2026) AS Revenue_26
    FROM
        (WITH
            base_table AS (
                SELECT
                campaign_id AS Campaign_ID,
                format_date("%G", date) AS Month,
                CAST(ROUND(SUM(revenue)) AS INT64) AS Revenue
                FROM `my-sql-project-513018.campaign_data.daily_performance`
                GROUP BY 1, 2
            )
            SELECT
            base_table.Campaign_ID AS Campaign_ID,
            (CASE WHEN Month = "2022" THEN base_table.Revenue END) AS Revenue_2022,
            (CASE WHEN Month = "2023" THEN base_table.Revenue END) AS Revenue_2023,
            (CASE WHEN Month = "2024" THEN base_table.Revenue END) AS Revenue_2024,
            (CASE WHEN Month = "2024" THEN base_table.Revenue END) AS Revenue_2025,
            (CASE WHEN Month = "2025" THEN base_table.Revenue END) AS Revenue_2026,
            FROM base_table
            GROUP BY 1, 2, 3, 4, 5, 6
        ) a
    LEFT JOIN `my-sql-project-513018.campaign_data.campaigns` b
    ON a.Campaign_ID = b.campaign_id
    Group BY 1