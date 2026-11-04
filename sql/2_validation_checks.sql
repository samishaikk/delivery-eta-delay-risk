
USE delivery_eta;

SELECT
    COUNT(*)                                                      AS total_rows,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END)           AS null_order_date,
    SUM(CASE WHEN time_taken_min IS NULL THEN 1 ELSE 0 END)       AS null_target,
    SUM(CASE WHEN delivery_person_age IS NULL THEN 1 ELSE 0 END)  AS null_age,
    SUM(CASE WHEN restaurant_lat = 0 OR restaurant_lon = 0 THEN 1 ELSE 0 END) AS zero_restaurant_coords,
    MIN(time_taken_min) AS min_target, MAX(time_taken_min) AS max_target
FROM dbo.vw_orders_clean;