-- ====================================================================
-- PROJECT: Food Delivery Performance Analytics
-- OBJECTIVE: Extract key performance metrics & chronological workflows
-- DESIGN: Notes App Chic / Monochromatic Minimalist
-- ====================================================================

-- 1. MACRO METRIC: Total Platform Revenue Spend
SELECT 
    ROUND(SUM(final_amount), 2) AS total_platform_revenue
FROM 
    Orders
WHERE 
    order_status = 'Delivered';


-- 2. CHRONOLOGICAL WORKFLOW: Orders Counted By 24-Hour Cycle
SELECT 
    DATE_PART('hour', order_time) AS order_hour,
    COUNT(order_id) AS total_orders_placed
FROM 
    Orders
GROUP BY 
    1
ORDER BY 
    1 ASC;


-- 3. PRODUCT VARIETY: Consumer Cuisine Preferences By Volume
SELECT 
    r.cuisine_type,
    COUNT(o.order_id) AS transaction_volume
FROM 
    Orders o
JOIN 
    Restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY 
    r.cuisine_type
ORDER BY 
    transaction_volume DESC;


-- 4. BASKET SIZE: Average Order Value (AOV) Regional Verification
SELECT 
    c.city_name,
    ROUND(AVG(o.final_amount), 2) AS average_order_value,
    COUNT(o.order_id) AS aggregate_order_count
FROM 
    Orders o
JOIN 
    Restaurants r ON o.restaurant_id = r.restaurant_id
JOIN 
    Cities c ON r.city_id = c.city_id
GROUP BY 
    c.city_name
ORDER BY 
    average_order_value DESC;