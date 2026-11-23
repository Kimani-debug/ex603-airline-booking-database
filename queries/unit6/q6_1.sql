--- Task 6.1: Compute across a window without collapsing

-- Compare each event to the flights average. Is an event unusual for its own flights?
-- Return every event with its flights average metric on the same row. Use AVG(...) OVER (PARTITION BY ...).
SELECT
    flight_id,
    AVG(fare_paid) OVER (PARTITION BY flight_id) AS fight_avg_metric
FROM bookings;
-- Then write the GROUP BY version and compare: how many rows does each return, and what is lost?
SELECT
    flight_id,
    AVG(fare_paid) AS flight_avg_metric
FROM bookings
GROUP BY flight_id;
-- returns 13 rows, and combine the 200 flight_ids recorded

-- Rank flights three ways. Leadership wants to publish a flights leaderboard. When two flights tie,
-- Rank flights by number of bookings using ROW_NUMBER(), RANK(), and DENSE_RANK(),
-- side by side in one query. Make sure your output shows at least one tie.
SELECT
    flight_id,
    COUNT(*) AS booking_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS row,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS dense_rank
FROM bookings
GROUP BY flight_id;


-- Sort flights into four bands. Use NTILE(4) to split flights into four groups by number of bookings.
-- Look at what happens when tied flights land on both sides of a group boundary.

SELECT
    flight_id,
    COUNT(*) AS bookings_count,
    NTILE(4) OVER (
        ORDER BY COUNT(*) DESC
        ) AS bookings_quartile
FROM bookings
GROUP BY flight_id
ORDER BY bookings_quartile, bookings_count DESC;