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

"""Question 4: Total spend and total revenue across all time. """

    SELECT
        sum(spend) AS Total_Spend,
        sum(revenue) AS Total_Revenue
    FROM
        `my-sql-project-513018.campaign_data.daily_performance`