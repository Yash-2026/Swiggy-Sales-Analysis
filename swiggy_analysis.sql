SELECT *
FROM swiggy_sales
LIMIT 10;

--SQL Query 1 – Total Revenue
SELECT
    SUM("Price (INR)") AS total_revenue
FROM swiggy_sales;

--SQL Query 2 – Total Orders
SELECT
    COUNT(*) AS total_orders
FROM swiggy_sales;

--SQL Query 3 – Average Order Value
SELECT
    ROUND(CAST(AVG("Price (INR)") AS numeric), 2) AS avg_order_value
FROM swiggy_sales;

-- SQL Query 4: Highest Order Value

SELECT
    MAX("Price (INR)") AS highest_order
FROM swiggy_sales;

-- SQL Query 5: Lowest Order Value

SELECT
    MIN("Price (INR)") AS lowest_order
FROM swiggy_sales;

-- SQL Query 6: Top 10 Cities by Revenue

SELECT
    "City",
    SUM("Price (INR)") AS revenue
FROM swiggy_sales
GROUP BY "City"
ORDER BY revenue DESC
LIMIT 10;

-- SQL Query 7: Revenue by State


SELECT
    "State",
    SUM("Price (INR)") AS revenue
FROM swiggy_sales
GROUP BY "State"
ORDER BY revenue DESC;

-- ==========================================
-- SQL Query 8: Monthly Revenue
-- ==========================================

SELECT
    TO_CHAR("Order Date", 'Mon') AS month,
    SUM("Price (INR)") AS revenue
FROM swiggy_sales
GROUP BY
    EXTRACT(MONTH FROM "Order Date"),
    TO_CHAR("Order Date", 'Mon')
ORDER BY
    EXTRACT(MONTH FROM "Order Date");

-- ==========================================
-- SQL Query 9: Average Rating by State
-- ==========================================

SELECT
    "State",
    ROUND(AVG("Rating")::numeric, 2) AS avg_rating
FROM swiggy_sales
GROUP BY "State"
ORDER BY avg_rating DESC;	

-- ==========================================
-- SQL Query 10: Top 10 Highest Value Orders
-- ==========================================

SELECT
    "Restaurant Name",
    "City",
    "Dish Name",
    "Price (INR)"
FROM swiggy_sales
ORDER BY "Price (INR)" DESC
LIMIT 10;

-- ==========================================
-- SQL Query 11: Revenue by Food Category
-- ==========================================

SELECT
    "Food Category",
    SUM("Price (INR)") AS revenue
FROM swiggy_sales
GROUP BY "Food Category"
ORDER BY revenue DESC;

-- ==========================================
-- SQL Query 12: Average Price by Food Category
-- ==========================================

SELECT
    "Food Category",
    ROUND(AVG("Price (INR)")::numeric, 2) AS avg_price
FROM swiggy_sales
GROUP BY "Food Category"
ORDER BY avg_price DESC;

-- ==========================================
-- SQL Query 13: Top Restaurants by Revenue
-- ==========================================

SELECT
    "Restaurant Name",
    SUM("Price (INR)") AS revenue
FROM swiggy_sales
GROUP BY "Restaurant Name"
ORDER BY revenue DESC
LIMIT 10;

-- ==========================================
-- SQL Query 14: Average Rating by Restaurant
-- ==========================================

SELECT
    "Restaurant Name",
    ROUND(AVG("Rating")::numeric,2) AS avg_rating
FROM swiggy_sales
GROUP BY "Restaurant Name"
ORDER BY avg_rating DESC
LIMIT 10;

-- ==========================================
-- SQL Query 15: Highest Rated Restaurants
-- ==========================================

SELECT
    "Restaurant Name",
    MAX("Rating") AS highest_rating
FROM swiggy_sales
GROUP BY "Restaurant Name"
ORDER BY highest_rating DESC
LIMIT 10;

-- ==========================================
-- SQL Query 16: Revenue by Category
-- ==========================================

SELECT
    "Category",
    SUM("Price (INR)") AS revenue
FROM swiggy_sales
GROUP BY "Category"
ORDER BY revenue DESC;

-- ==========================================
-- SQL Query 17: Average Rating by Category
-- ==========================================

SELECT
    "Category",
    ROUND(AVG("Rating")::numeric,2) AS avg_rating
FROM swiggy_sales
GROUP BY "Category"
ORDER BY avg_rating DESC;

-- ==========================================
-- SQL Query 18: Revenue by Location
-- ==========================================

SELECT
    "Location",
    SUM("Price (INR)") AS revenue
FROM swiggy_sales
GROUP BY "Location"
ORDER BY revenue DESC;

-- ==========================================
-- SQL Query 19: Most Expensive Dishes
-- ==========================================

SELECT
    "Dish Name",
    "Restaurant Name",
    "Price (INR)"
FROM swiggy_sales
ORDER BY "Price (INR)" DESC
LIMIT 10;

-- ==========================================
-- SQL Query 20: Restaurants Above Average Price
-- ==========================================

SELECT
    "Restaurant Name",
    "Dish Name",
    "Price (INR)"
FROM swiggy_sales
WHERE "Price (INR)" >
(
    SELECT AVG("Price (INR)")
    FROM swiggy_sales
)
ORDER BY "Price (INR)" DESC;

-- ==========================================
-- SQL Query 21: Revenue Rank by State
-- ==========================================

SELECT
    "State",
    SUM("Price (INR)") AS revenue,
    RANK() OVER (ORDER BY SUM("Price (INR)") DESC) AS revenue_rank
FROM swiggy_sales
GROUP BY "State";

-- ==========================================
-- SQL Query 22: Top Restaurant in Each State
-- ==========================================

WITH restaurant_sales AS (
    SELECT
        "State",
        "Restaurant Name",
        SUM("Price (INR)") AS revenue,
        RANK() OVER(
            PARTITION BY "State"
            ORDER BY SUM("Price (INR)") DESC
        ) AS rnk
    FROM swiggy_sales
    GROUP BY "State","Restaurant Name"
)

SELECT *
FROM restaurant_sales
WHERE rnk = 1;

-- ==========================================
-- SQL Query 23: Revenue Contribution %
-- ==========================================

SELECT
    "Food Category",
    ROUND(
        (
            SUM("Price (INR)") * 100.0 /
            (SELECT SUM("Price (INR)") FROM swiggy_sales)
        )::numeric,
        2
    ) AS revenue_percentage
FROM swiggy_sales
GROUP BY "Food Category";

-- ==========================================
-- SQL Query 24: Premium Orders
-- ==========================================

SELECT
    "Restaurant Name",
    "Dish Name",
    "Price (INR)"
FROM swiggy_sales
WHERE "Price (INR)" >
(
    SELECT
        AVG("Price (INR)") + STDDEV("Price (INR)")
    FROM swiggy_sales
)
ORDER BY "Price (INR)" DESC;

-- ==========================================
-- SQL Query 25: Top Rated Cities
-- ==========================================

SELECT
    "City",
    ROUND(AVG("Rating")::numeric,2) AS avg_rating
FROM swiggy_sales
GROUP BY "City"
ORDER BY avg_rating DESC
LIMIT 10;

-- ==========================================
-- SQL Query 26: Average Price by State
-- ==========================================

SELECT
    "State",
    ROUND(AVG("Price (INR)")::numeric,2) AS avg_price
FROM swiggy_sales
GROUP BY "State"
ORDER BY avg_price DESC;


-- ==========================================
-- SQL Query 27: Revenue by Quarter
-- ==========================================

SELECT
    "Quarter",
    SUM("Price (INR)") AS revenue
FROM swiggy_sales
GROUP BY "Quarter"
ORDER BY "Quarter";

-- ==========================================
-- SQL Query 28: Average Rating by Food Category
-- ==========================================

SELECT
    "Food Category",
    ROUND(AVG("Rating")::numeric,2) AS avg_rating
FROM swiggy_sales
GROUP BY "Food Category"
ORDER BY avg_rating DESC;

-- ==========================================
-- SQL Query 29: Revenue by Day
-- ==========================================

SELECT
    "DayName",
    SUM("Price (INR)") AS revenue
FROM swiggy_sales
GROUP BY "DayName"
ORDER BY revenue DESC;

-- ==========================================
-- SQL Query 30: Overall Business Summary
-- ==========================================

SELECT
    COUNT(*) AS total_orders,
    SUM("Price (INR)") AS total_revenue,
    ROUND(AVG("Price (INR)")::numeric,2) AS avg_order_value,
    MAX("Price (INR)") AS highest_order,
    MIN("Price (INR)") AS lowest_order,
    ROUND(AVG("Rating")::numeric,2) AS avg_rating
FROM swiggy_sales;