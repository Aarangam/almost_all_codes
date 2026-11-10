""" Question 1: Look at the first 10 rows of the performance table."""

    SELECT * FROM `my-sql-project-513018.campaign_data.daily_performance` LIMIT 10

"""Question 2: B2. How many rows are in the performance table, and what is the first and last date?"""

    SELECT
        count(*) AS No_of_rows,
        min(date) AS first_day,
        max(date) AS last_day,
    FROM
        `my-sql-project-513018.campaign_data.daily_performance`

"""Question 3: List the distinct channels."""

    SELECT DISTINCT channel FROM `my-sql-project-513018.campaign_data.campaigns`

"""Question 4: Show all campaigns on the Meta platform."""

    SELECT 
        campaign_name
    FROM 
        `my-sql-project-513018.campaign_data.campaigns`
    WHERE 
        platform = "Meta"

"""Question 5: Total spend and total revenue across all time. """

    SELECT
        sum(spend) AS Total_Spend,
        sum(revenue) AS Total_Revenue
    FROM
        `my-sql-project-513018.campaign_data.daily_performance`

"""Question 6: Total spend per region, highest first. """

    SELECT 
        region, 
        round(sum(spend),2) AS Total_spend
    FROM 
        `my-sql-project-513018.campaign_data.daily_performance`
    GROUP BY 
        1
    ORDER BY round(sum(spend),2) DESC

"""Question 7: Rows on Black Friday 2025 (2025-11-28) with more than 100 conversions."""


    SELECT 
        *
    FROM 
        `my-sql-project-513018.campaign_data.daily_performance`
    WHERE
        date = "2025-11-28"
        AND conversions > 100

"""Question 8: Performance rows between 2024-06-01 and 2024-06-30 for campaigns 101, 102 and 201."""

    SELECT
        *
    FROM
        `my-sql-project-513018.campaign_data.daily_performance`
    WHERE
        date >= "2024-06-01"
        AND date <= "2024-06-30"
        AND campaign_id IN (101, 102, 201)
    ORDER BY date
