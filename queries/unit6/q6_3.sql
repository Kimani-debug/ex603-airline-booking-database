-- Part A: Top N per category
-- Return the top three events by metric for each producer. Most leaderboards and recommendation features are built this way.
--
-- ✓ A ranking window function, partitioned by producer.
-- ✓ A CTE or subquery that filters to rank <= 3.
-- ✓ FIRST_VALUE() or LAST_VALUE() used somewhere in your solution. If you use LAST_VALUE(), add ROWS BETWEEN UNBOUNDED
-- PRECEDING AND UNBOUNDED FOLLOWING; with the default frame it returns the wrong value.
-- ✓ A comment saying how ties at third place are handled, and why.
WITH fares AS(
    SELECT
        flight_id,
        booked_at,
        fare_paid,
        booking_country,
        FIRST_VALUE(fare_paid) OVER (
            PARTITION BY flight_id
            ORDER BY fare_paid DESC
            ) AS top_fare,
        RANK() OVER (
        PARTITION BY flight_id
        ORDER BY fare_paid DESC
        ) AS flight_rank
    FROM bookings
)
SELECT
    flight_id,
    fare_paid,
    booking_country,
    flight_rank
FROM fares
WHERE flight_rank <= 3
ORDER BY flight_id, flight_rank;

-- Ties in the 3rd place are handled different using RANK() since it gives two values that are the
-- same rank number.


-- Part B: Period over period
-- Is the platform getting better or worse each month? This is the founder’s real question.
-- Group your events by calendar month, then compare each month with the month before.
--
-- ✓ Group events into months (for example, with DATE_TRUNC('month', ...)).
-- ✓ LAG() over the monthly series.
-- ✓ A percent-change column that avoids division by zero (for example, with NULLIF(..., 0)).
-- ✓ A check for missing months. LAG counts rows, so a missing month makes it compare the wrong months.
WITH monthly_series AS(
    SELECT
        DATE_TRUNC('month', booked_at)::date AS month,
        COUNT(*) AS bookings
    FROM bookings
    GROUP BY DATE_TRUNC('month', booked_at)::date
),
gaps AS(
    SELECT
        month,
        bookings,
        LAG(month) OVER (ORDER BY month) AS previous_month,
        LAG(bookings) OVER (ORDER BY month) AS previous_bookings
    FROM monthly_series
)
SELECT
    month,
    bookings,
    previous_bookings,
    (previous_month + INTERVAL '1 month'):: date AS gap_start,
    (month - INTERVAL '1 month'):: date AS gap_end,
    ROUND(100.0 * (bookings - LAG(bookings) OVER (ORDER BY month))
    / NULLIF(LAG(bookings) OVER (ORDER BY month), 0), 2) AS percent_change
FROM gaps
ORDER BY month;
