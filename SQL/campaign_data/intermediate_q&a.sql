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

"""Classify each campaign's overall ROAS as 'Great' (>=6), 'Good' (3 to <6), or 'Poor' (<3) using CASE."""

    
