/*1. Most Watched Genres
This query retrieves the top 5 most-watched genres.*/

SELECT 
    g.genre_name AS Genre,
    COUNT(w.watch_id) AS WatchCount
FROM 
    watch_history w
JOIN 
    movies m ON w.movie_id = m.movie_id
JOIN 
    genres g ON m.genre_id = g.genre_id
GROUP BY 
    g.genre_name
ORDER BY 
    WatchCount DESC
LIMIT 5;


/*2. Top 10 Most Popular Movies
This query lists the top 10 movies based on watch count.*/
 
SELECT 
    m.title AS MovieTitle,
    COUNT(w.watch_id) AS WatchCount
FROM 
    watch_history w
JOIN 
    movies m ON w.movie_id = m.movie_id
GROUP BY 
    m.title
ORDER BY 
    WatchCount DESC
LIMIT 10;


/*3. Average Watch Time by Subscription Plan
This query calculates the average watch time for each subscription plan.*/


SELECT 
    s.plan AS SubscriptionPlan,
    AVG(w.watch_time) AS AvgWatchTime
FROM 
    watch_history w
JOIN 
    subscriptions s ON w.user_id = s.user_id
GROUP BY 
    s.plan
ORDER BY 
    AvgWatchTime DESC;
    
    
    /*4. Monthly Revenue from Subscriptions
This query calculates the total monthly revenue from subscriptions.*/


SELECT 
    DATE_FORMAT(s.subscription_date, '%Y-%m') AS SubscriptionMonth,
    SUM(s.price) AS TotalRevenue
FROM 
    subscriptions s
GROUP BY 
    SubscriptionMonth
ORDER BY 
    SubscriptionMonth ASC;
    
    
    /*5. User Retention: Active Users per Month
This query determines the number of unique active users per month based on their watch history.*/


SELECT 
    DATE_FORMAT(w.watch_date, '%Y-%m') AS WatchMonth,
    COUNT(DISTINCT w.user_id) AS ActiveUsers
FROM 
    watch_history w
GROUP BY 
    WatchMonth
ORDER BY 
    WatchMonth ASC;
    
    
    
   /* 6. Top Performing Genres by Watch Time
This query calculates the total watch time for each genre.*/


SELECT 
    g.genre_name AS Genre,
    SUM(w.watch_time) AS TotalWatchTime
FROM 
    watch_history w
JOIN 
    movies m ON w.movie_id = m.movie_id
JOIN 
    genres g ON m.genre_id = g.genre_id
GROUP BY 
    g.genre_name
ORDER BY 
    TotalWatchTime DESC;
    
    
 /*   7. User Segmentation by Subscription Plan
This query shows the count of users for each subscription plan.*/


SELECT 
    s.plan AS SubscriptionPlan,
    COUNT(DISTINCT s.user_id) AS UserCount
FROM 
    subscriptions s
GROUP BY 
    s.plan
ORDER BY 
    UserCount DESC;
    
    
   /* 8. Movies with Highest Average Ratings
This query identifies the top-rated movies.*/

SELECT 
    m.title AS MovieTitle,
    m.rating AS AverageRating
FROM 
    movies m
WHERE 
    m.rating IS NOT NULL
ORDER BY 
    m.rating DESC
LIMIT 10;


/*9. Peak Watching Times
This query identifies the hours with the most user activity.*/


SELECT 
    HOUR(w.watch_date) AS WatchHour,
    COUNT(w.watch_id) AS WatchCount
FROM 
    watch_history w
GROUP BY 
    WatchHour
ORDER BY 
    WatchCount DESC;
    
    
    
  /*  10. User Activity Across Age Groups
This query determines watch counts for each age group.*/

SELECT 
    u.age_group AS AgeGroup,
    COUNT(w.watch_id) AS WatchCount
FROM 
    watch_history w
JOIN 
    users u ON w.user_id = u.user_id
GROUP BY 
    u.age_group
ORDER BY 
    WatchCount DESC;
    
    
  /*  11. Identify Top-Spending Users*/

SELECT 
    u.user_id, 
    u.name AS user_name, 
    SUM(s.price) AS total_spent
FROM 
    users u
JOIN 
    subscriptions s ON u.user_id = s.user_id
GROUP BY 
    u.user_id, u.name
ORDER BY 
    total_spent DESC
LIMIT 10;



/*12. Monthly Churn Rate*/

SELECT 
    DATE_FORMAT(s.end_date, '%Y-%m') AS month,
    COUNT(DISTINCT s.user_id) AS churned_users,
    (COUNT(DISTINCT s.user_id) * 100.0) / (SELECT COUNT(*) FROM users) AS churn_rate
FROM 
    subscriptions s
WHERE 
    s.end_date IS NOT NULL
GROUP BY 
    month
ORDER BY 
    month;
    
    
    
   /* 13. Genre Popularity by Country*/

SELECT 
    g.genre_name, 
    u.country, 
    COUNT(w.movie_id) AS watch_count
FROM 
    watch_history w
JOIN 
    users u ON w.user_id = u.user_id
JOIN 
    movies m ON w.movie_id = m.movie_id
JOIN 
    genres g ON m.genre_id = g.genre_id
GROUP BY 
    g.genre_name, u.country
ORDER BY 
    watch_count DESC
LIMIT 20;



/*14. Average User Watch Time by Subscription Plan*/

SELECT 
    s.plan AS subscription_plan, 
    AVG(w.watch_time) AS avg_watch_time
FROM 
    watch_history w
JOIN 
    subscriptions s ON w.user_id = s.user_id
GROUP BY 
    s.plan
ORDER BY 
    avg_watch_time DESC;
    
    
    
    /*15. Peak Viewing Times*/

SELECT 
    HOUR(w.watch_date) AS hour,
    COUNT(w.user_id) AS watch_count
FROM 
    watch_history w
GROUP BY 
    hour
ORDER BY 
    watch_count DESC;
    
    
    
/*16. User Retention by Registration Month*/

SELECT 
    DATE_FORMAT(u.registration_date, '%Y-%m') AS registration_month,
    COUNT(DISTINCT u.user_id) AS total_users,
    COUNT(DISTINCT s.user_id) AS active_users,
    (COUNT(DISTINCT s.user_id) * 100.0) / COUNT(DISTINCT u.user_id) AS retention_rate
FROM 
    users u
LEFT JOIN 
    watch_history s ON u.user_id = s.user_id
GROUP BY 
    registration_month
ORDER BY 
    registration_month;
    
    
    
    /*17. Subscription Revenue by Plan*/

SELECT 
    s.plan AS subscription_plan, 
    SUM(s.price) AS total_revenue
FROM 
    subscriptions s
GROUP BY 
    s.plan
ORDER BY 
    total_revenue DESC;
    
    
  /*  18. Identify Movies with Low Ratings but High Views*/

SELECT 
    m.movie_title, 
    m.rating, 
    COUNT(w.user_id) AS watch_count
FROM 
    watch_history w
JOIN 
    movies m ON w.movie_id = m.movie_id
WHERE 
    m.rating < 3
GROUP BY 
    m.movie_title, m.rating
ORDER BY 
    watch_count DESC
LIMIT 10;



/*19. New Users per Month*/

SELECT 
    DATE_FORMAT(u.registration_date, '%Y-%m') AS month,
    COUNT(*) AS new_users
FROM 
    users u
GROUP BY 
    month
ORDER BY 
    month;
    
    
    
    /*20. Top 10 Countries with Highest Subscription Revenue*/

SELECT 
    u.country, 
    SUM(s.price) AS total_revenue
FROM 
    subscriptions s
JOIN 
    users u ON s.user_id = u.user_id
GROUP BY 
    u.country
ORDER BY 
    total_revenue DESC
LIMIT 10;


/*21. Most Watched Movies by Premium Users*/

SELECT 
    m.movie_title, 
    COUNT(w.user_id) AS watch_count
FROM 
    watch_history w
JOIN 
    subscriptions s ON w.user_id = s.user_id
JOIN 
    movies m ON w.movie_id = m.movie_id
WHERE 
    s.plan = 'Premium'
GROUP BY 
    m.movie_title
ORDER BY 
    watch_count DESC
LIMIT 10;



/*22. Average Subscription Duration by Plan*/

SELECT 
    s.plan, 
    AVG(DATEDIFF(s.end_date, s.start_date)) AS avg_subscription_duration
FROM 
    subscriptions s
GROUP BY 
    s.plan
ORDER BY 
    avg_subscription_duration DESC;
    
    
    
    
    
    
    
    /*23. Monthly Revenue Growth Rate*/

WITH MonthlyRevenue AS (
    SELECT 
        DATE_FORMAT(s.start_date, '%Y-%m') AS month,
        SUM(s.price) AS revenue
    FROM 
        subscriptions s
    GROUP BY 
        month
)
SELECT 
    month,
    revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS revenue_change,
    ROUND(((revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month)) * 100, 2) AS growth_rate
FROM 
    MonthlyRevenue;
    
    
    
    /*24. Most Consistent Viewers by Monthly Watch Time*/

WITH MonthlyUserWatch AS (
    SELECT 
        w.user_id,
        DATE_FORMAT(w.watch_date, '%Y-%m') AS month,
        SUM(w.watch_time) AS monthly_watch_time
    FROM 
        watch_history w
    GROUP BY 
        w.user_id, month
)
SELECT 
    user_id,
    AVG(monthly_watch_time) AS avg_monthly_watch_time,
    STDDEV(monthly_watch_time) AS watch_time_variability
FROM 
    MonthlyUserWatch
GROUP BY 
    user_id
ORDER BY 
    watch_time_variability ASC
LIMIT 10;



/*25. Top Genres Watched by Country*/

WITH GenreWatchCount AS (
    SELECT 
        u.country,
        g.genre_name,
        COUNT(w.movie_id) AS watch_count
    FROM 
        watch_history w
    JOIN 
        movies m ON w.movie_id = m.movie_id
    JOIN 
        genres g ON m.genre_id = g.genre_id
    JOIN 
        users u ON w.user_id = u.user_id
    GROUP BY 
        u.country, g.genre_name
)
SELECT 
    country,
    genre_name,
    watch_count,
    RANK() OVER (PARTITION BY country ORDER BY watch_count DESC) AS ranks
FROM 
    GenreWatchCount
WHERE 
    ranks <= 1;
    
    
    
   