-- 3.2a The broken query, the count of what it dropped, and the repair

-- Pick a nullable column on your event or producer table. If the dataset has no NULLs in it, insert a few deliberately and say that you did.
-- Write a query with a negation or inequality predicate on that column — for example WHERE status != 'completed' — and record the row count it returns.
SELECT COUNT(*)
FROM bookings
WHERE cancellation_reason != 'Passenger no show';
-- Prints 1

-- Write a second query counting the rows the first one silently omitted, and show that the two counts do not sum to the table total.
SELECT COUNT(*)
FROM bookings
WHERE cancellation_reason IS NULL;
-- Prints 168

-- Repair the first query using an explicit IS NULL condition or COALESCE, so it returns what you intended.
SELECT COUNT(*)
FROM bookings
WHERE cancellation_reason != 'Passenger no show' OR cancellation_reason IS NULL;
--Prints 169

-- 3.2b The alias that did not exist yet
-- SQL is written FROM, WHERE, SELECT, ORDER BY, but it is not evaluated in that order.

-- Write a query defining an alias in SELECT and referencing that alias in WHERE. Capture the error message verbatim.
SELECT bookings.passenger_id, fare_paid, bookings.fare_paid * bookings.fare_multiplier AS
    reward_points
FROM bookings
WHERE reward_points > 20;
-- ERROR: column "reward_points" does not exist

-- Produce two correct rewrites: one repeating the expression in WHERE, one wrapping the query in a CTE or subquery so the alias becomes a real column.
SELECT bookings.passenger_id, fare_paid, bookings.fare_paid * bookings.fare_multiplier AS
    reward_points
FROM bookings
WHERE bookings.fare_paid * bookings.fare_multiplier > 60;

WITH high_reward_passengers AS (
    SELECT bookings.passenger_id
    FROM bookings
    WHERE fare_multiplier > 1.5
)
SELECT passengers.passenger_id
FROM passengers

JOIN bookings ON passengers.passenger_id = bookings.passenger_id
WHERE bookings.passenger_id NOT IN (
    SELECT passenger_id
    FROM high_reward_passengers
)
;