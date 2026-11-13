-- Part A: Compare INNER JOIN and LEFT JOIN
--
-- Write two queries to compare the results of an inner join and a left join.

-- 1. Use LEFT JOIN to return all flights, including those who have never had an bookings.
SELECT
    f.flight_id,
    COUNT(b.booking_id) AS booking_count
FROM flights f
LEFT JOIN bookings b ON b.flight_id = f.flight_id
GROUP BY f.flight_id
ORDER BY booking_count DESC;

-- 2. Write an equivalent query using INNER JOIN.
SELECT
    f.flight_id,
    COUNT(b.booking_id) AS booking_count
FROM flights f
INNER JOIN bookings b ON b.flight_id = f.flight_id
GROUP BY f.flight_id
ORDER BY f.flight_id ASC;


-- Part B: Explore RIGHT JOIN and FULL OUTER JOIN
--    1 Write a RIGHT JOIN that returns the same records as your LEFT JOIN from Part A.
SELECT
    f.flight_id,
    COUNT(b.booking_id) AS booking_count
FROM bookings b
RIGHT JOIN flights f ON b.flight_id = f.flight_id
GROUP BY f.flight_id
ORDER BY flight_id ASC;

--    3 Write a FULL OUTER JOIN that includes matching and unmatched records from both tables.
SELECT
    COALESCE(f.flight_id, b.flight_id) AS flight_id,
    COUNT(b.booking_id) AS booking_count,
    CASE
        WHEN COUNT(f.flight_id) = 0 THEN 'flight only'
        WHEN COUNT(b.flight_id) = 0 THEN 'booking only'
        ELSE 'both'
    END AS stats
FROM bookings b
    FULL OUTER JOIN flights f ON b.flight_id = f.flight_id
GROUP BY COALESCE(f.flight_id, b.flight_id)
ORDER BY COALESCE(f.flight_id, b.flight_id) ASC;
-- 4 Explain what a full outer join can reveal that a left join or right join alone may not show.

-- Be sure to verify your results rather than assuming the queries are equivalent.



-- Part C: Find Producers with No Events Using Two Approaches
-- Write two queries that identify producers who have never had an event and compare them.
-- ✓  NOT EXISTS.
SELECT f.flight_id, f.flight_number
FROM flights f
WHERE NOT EXISTS (SELECT 1
                  FROM bookings b
                  WHERE b.flight_id = f.flight_id)
ORDER BY f.flight_id;

-- ✓  EXCEPT.
SELECT f.flight_id FROM flights f
EXCEPT
SELECT b.flight_id FROM bookings b;
--
-- Run both queries and compare their results.
--
-- In one or two sentences, explain how the approaches differ and confirm whether they identify the same producers.