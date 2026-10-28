-- Task 4.2: Build the breakdown leadership asked for

-- Part A: Two numbers in one pass
-- For each flights, compute the total number of bookings and the total number of bookings classified as failures,
-- in a single pass over the bookings table, without a WHERE clause filtering the whole query.
-- The outliers here are the flights you will name in your finding.
-- CASE used inside an aggregate — for example SUM(CASE WHEN ... THEN 1 ELSE 0 END) or COUNT(CASE WHEN ... END).
-- Both totals appearing as separate columns in one result set.

SELECT
    flight_id,
    COUNT(booking_id) AS booking_count,
    COUNT(CASE WHEN booking_status = 'cancelled' THEN 1 END) AS booking_failures
FROM bookings
GROUP BY flight_id;

-- Part B: Subtotals and a grand total
-- The regional director wants subtotals per region and a platform grand total, not the detail rows.
-- Write a query that produces regional subtotals and a platform-wide grand total without including the individual detail rows.
-- GROUP BY ROLLUP (...), or GROUPING SETS or CUBE.
-- A written note identifying which rows are the subtotals and which is the grand total.
SELECT
    booking_country, --subtotal rows
    COUNT(booking_id),
    COUNT(CASE WHEN booking_status = 'cancelled' THEN 1 END)
FROM bookings
GROUP BY ROLLUP(booking_country);
--<null> = grand total

-- Part C: A two-step pipeline
-- Leadership wants to establish a baseline for evaluating high-volume producers.
-- That needs two steps: use a WITH clause to create an intermediate result that summarizes performance for each flights,
-- then use a second aggregation or filter on that intermediate result to calculate a baseline for high-volume flights.
-- A WITH clause producing an intermediate aggregate.
-- A second aggregation or filter applied to that intermediate result.
WITH flight_stats AS (
    SELECT
        flight_id,
        COUNT(*) as booking_count,
        COUNT(CASE WHEN booking_status = 'confirmed' THEN 1 END) AS successful_bookings,
        AVG(fare_paid) AS avg_fare
    FROM bookings
    GROUP BY flight_id
),
popular_flights AS (
    SELECT *
    FROM flight_stats
    WHERE booking_count > 15
)

SELECT
    COUNT(*) AS popular_flight_count,
    AVG(avg_fare) AS high_volume_avg_fare
FROM popular_flights

