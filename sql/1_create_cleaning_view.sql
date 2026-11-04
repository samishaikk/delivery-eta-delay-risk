use delivery_eta;

GO
CREATE OR ALTER VIEW dbo.vw_orders_clean AS
SELECT
    TRIM(ID)                                                         AS order_id,
    TRIM(Delivery_person_ID)                                         AS delivery_person_id,
    TRY_CAST(NULLIF(TRIM(Delivery_person_Age), 'NaN') AS INT)        AS delivery_person_age,
    TRY_CAST(NULLIF(TRIM(Delivery_person_Ratings), 'NaN') AS DECIMAL(3,1)) AS delivery_person_rating,
    TRY_CAST(Restaurant_latitude AS DECIMAL(9,6))                    AS restaurant_lat,
    TRY_CAST(Restaurant_longitude AS DECIMAL(9,6))                   AS restaurant_lon,
    TRY_CAST(Delivery_location_latitude AS DECIMAL(9,6))             AS delivery_lat,
    TRY_CAST(Delivery_location_longitude AS DECIMAL(9,6))            AS delivery_lon,
    TRY_CONVERT(DATE, TRIM(Order_Date), 105)                         AS order_date,
    TRY_CAST(NULLIF(TRIM(Time_Orderd), 'NaN') AS TIME(0))            AS time_ordered,
    TRY_CAST(NULLIF(TRIM(Time_Order_picked), 'NaN') AS TIME(0))      AS time_order_picked,
    NULLIF(TRIM(REPLACE(Weatherconditions, 'conditions ', '')), 'NaN') AS weather,
    NULLIF(TRIM(Road_traffic_density), 'NaN')                        AS traffic_density,
    TRY_CAST(Vehicle_condition AS INT)                               AS vehicle_condition,
    TRIM(Type_of_order)                                              AS order_type,
    TRIM(Type_of_vehicle)                                            AS vehicle_type,
    TRY_CAST(NULLIF(TRIM(multiple_deliveries), 'NaN') AS INT)        AS multiple_deliveries,
    NULLIF(TRIM(Festival), 'NaN')                                    AS festival,
    CASE WHEN TRIM(City) = 'Metropolitian' THEN 'Metropolitan'
         ELSE NULLIF(TRIM(City), 'NaN') END                          AS city,
    TRY_CAST(TRIM(REPLACE(Time_taken_min, '(min)', '')) AS INT)      AS time_taken_min
FROM dbo.stg_orders_raw;

