-- 3.1a Active, highly rated drivers — the producers whose records
--    anchor the audit. Requirement: SELECT, WHERE, ORDER BY, LIMIT.

-- Find active, highly rated flights. Use your theme’s filter condition from the appendix. Sort them and return the first ten.
SELECT flight_number
FROM flights
WHERE is_active = TRUE
LIMIT 10;

-- Find all possible bookings statuses. Display the distinct values in the bookings status column. Look carefully at the results. Are there more statuses than you expected?
SELECT booking_status
FROM bookings;

-- Filter the bookings in two different ways. Write: one query that filters a numeric range, and one query that filters using an explicit list of values with IN.
SELECT booked_at
FROM bookings
WHERE booked_at BETWEEN '2023-02-01' AND '2023-06-30';

SELECT passenger_name
FROM passengers
WHERE home_country IN ('Vietnam','Japan');

-- Work with text and missing values. Write queries that: find producers whose names match a text pattern using LIKE, and identify records where a reason/value is missing (NULL). Use COALESCE to replace a missing value with a useful label such as: No reason provided.
SELECT flights.flight_number
FROM flights
WHERE origin_country LIKE 'Korea';

SELECT passenger_id,
       COALESCE(bookings.cancellation_reason, 'Not applicable') AS Cancelled
FROM bookings;

-- Make the results easier to understand. Create a query with calculated/computed columns that would make sense to someone who does not work with SQL. Depending on your theme, you might calculate or label:
    -- a payout amount,
    -- a time of day,
    -- a value/rating category,
    -- or another useful business measure.
SELECT bookings.passenger_id, fare_paid, bookings.fare_paid * bookings.fare_multiplier AS
    reward_points
FROM bookings;

--Use CASE where appropriate to create plain-language categories.
SELECT flight_id, flight_routes.effective_from,
       CASE
           WHEN flight_routes.effective_from < '2023-04-21' THEN 'winter'
           WHEN flight_routes.effective_from < '2023-06-22' THEN 'spring'
           WHEN flight_routes.effective_from < '2023-09-22' THEN 'summer'
           WHEN flight_routes.effective_from < '2023-12-21' THEN 'fall'
           ELSE 'winter'
       END AS seasons
FROM flight_routes;