-- Task 3.3: Hand the team a corrected query

-- Answer a two-step question about your data — for example, which actors were involved in the disputed events — and express it three ways.
-- First as a subquery using IN or NOT IN.
SELECT passengers.passenger_id
FROM passengers
WHERE passenger_id IN (
    SELECT passenger_id
    FROM bookings
    WHERE cancellation_reason = 'Passenger no show');

-- Then as a Common Table Expression using WITH.
WITH no_show AS (
    SELECT passenger_id
    FROM bookings
    WHERE cancellation_reason = 'Passenger no show'
)
SELECT passengers.passenger_id
FROM passengers
WHERE passengers.passenger_id IN (SELECT passenger_id FROM no_show);

-- Then a third way, distinct from both — a different subquery form, a CASE-based construction, or a set-based approach.
SELECT passengers.passenger_id
FROM passengers
WHERE EXISTS (
    SELECT 1
    FROM bookings
    WHERE bookings.passenger_id = passengers.passenger_id
        AND bookings.cancellation_reason = 'Passenger no show'
);

-- Demonstrate that all three return identical result sets. Matching row counts is not enough: show that the rows themselves match.

-- Name one input condition under which the three would not be equivalent. NULLs, duplicates, and empty result sets are the usual places equivalence breaks.
-- Answer: