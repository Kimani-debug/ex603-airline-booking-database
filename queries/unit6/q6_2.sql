-- Part A: Row to row
-- Is a flight’s metric going up or down over time, not just high or low overall?
-- For each event, show the metric from the previous event and the next event, in time order.
-- ✓  LAG() and LEAD(), partitioned by producer and ordered by timestamp.
-- ✓  A delta column: the current metric minus the previous metric.
-- ✓ In the final output, filter to one producer of your choice so the trend is easy to read.
    SELECT
        flight_id,
        booked_at,
        fare_paid,
        LAG(fare_paid, 1, 0) OVER (
            PARTITION BY flight_id ORDER BY booked_at
            ) AS flights_1_day_ago,
        LEAD(fare_paid, 1, 0) OVER (
            PARTITION BY flight_id ORDER BY booked_at
            ) AS flights_1_day_later,
        fare_paid - LAG(fare_paid, 1, 0) OVER (
            PARTITION BY flight_id ORDER BY booked_at
            ) AS delta
    FROM bookings
    WHERE flight_id = 3
    ORDER BY booked_at;


-- Part B: Cumulative and smoothed
-- How is the platform doing over time, both in total and on a recent average? Leadership wants to see where things
-- stand now and how they got there.
-- ✓ SUM(...) OVER (ORDER BY ... ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) for a running total.
-- ✓ AVG(...) OVER (... ROWS BETWEEN n PRECEDING AND CURRENT ROW) for a moving average. Note: ROWS counts rows, not days.
-- If some days have no events, a 7-row window covers more than 7 days.
-- ✓ Choose a target (for example, a total for the quarter), state it, and show how close the running total gets to it.
-- ✓ One or two sentences on how ROWS differs from RANGE when two rows have the same ORDER BY value.

WITH daily_bookings AS (
    SELECT
        flight_id,
        booked_at::date AS booking_date,
        COUNT(*)        AS bookings
    FROM bookings
    WHERE booked_at >= '2023-04-01' AND booked_at < '2023-07-01'
    GROUP BY flight_id, booked_at::date
)

SELECT
    booking_date,
    bookings,
    SUM(bookings) OVER (
        ORDER BY booking_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )
        AS bookings_q2,
    ROUND(AVG(bookings) OVER
        (ORDER BY booking_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
        , 2) AS moving_avg,
    25 AS q2_target,
    ROUND(100.0 * SUM(bookings) OVER(
        ORDER BY booking_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) /50, 2) AS target
FROM daily_bookings
ORDER BY booking_date;

--Part C: Where the series stops
-- One producer stops for a while and then starts again. Find that gap. Then think about what you cannot tell yet:
-- did the producer leave, or did your data lose them?
-- ✓  LAG() or LEAD() comparing adjacent rows.
-- ✓  A CTE or subquery that computes the gap, and a WHERE in the outer query that keeps only the gaps.
-- (You cannot filter a window function result with WHERE or HAVING in the same query, because the window function runs after them.)
WITH fares AS(
    SELECT
        flight_id,
        booked_at,
        fare_paid,
        LAG(booked_at, 1) OVER (
            PARTITION BY flight_id ORDER BY booked_at
            ) AS previous_booking,
        LEAD(booked_at, 1) OVER (
            PARTITION BY flight_id ORDER BY booked_at
            ) AS next_booking,
        booked_at - LAG(booked_at, 1) OVER (
            PARTITION BY flight_id ORDER BY booked_at
            ) AS delta
    FROM bookings
)

SELECT *
FROM fares
WHERE delta >= INTERVAL '30 days'
ORDER BY booked_at;