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