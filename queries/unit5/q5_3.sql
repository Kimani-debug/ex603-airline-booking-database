-- Part A: Explore CROSS JOIN
-- Write a CROSS JOIN between two small tables.
SELECT
    fr.flight_id,
    a.airport_name
FROM flight_routes fr
    CROSS JOIN airports a
ORDER BY fr.flight_id, a.airport_name;
-- Then:
--
--     Count the rows in each source table.
--     Run the CROSS JOIN and count the resulting rows.
--     Show how the result matches the multiplication of the two source table counts.
--     Explain when a Cartesian product might be useful and when it could indicate a query error.
--
-- For example, if one table has 5 rows and another has 4 rows, the cross join produces 20 rows.
--
-- Choose small tables so the result is manageable.



-- Part B: Examine a Query Execution Plan
--
-- Return to your three-table join from Task 5.1, Part A.
-- Use PostgreSQL's EXPLAIN command to examine how the database plans to execute the query.
--
EXPLAIN ANALYZE
SELECT
    p.passenger_name,
    b.booked_at,
    f.flight_number
FROM bookings b
         JOIN passengers p ON b.passenger_id = p.passenger_id
         INNER JOIN flights f on f.flight_id = b.flight_id;

EXPLAIN
SELECT
    f.flight_number,
    a.iata_code
FROM flights f
         JOIN flight_routes fr ON f.flight_id = fr.flight_id
         JOIN airports a ON fr.airport_id = a.airport_id;

EXPLAIN
SELECT
    f.flight_id AS flight,
    f2.flight_id AS flight_2,
    f.origin_country AS active_oc
FROM flights f
         JOIN flights f2 ON f.origin_country = f2.origin_country;

-- EXPLAIN ANALYZE also runs the query and reports actual timings.
-- Safe here; be careful with it on statements that modify data.
--
--
-- Review the execution plan and complete the following:
--
--     Capture the full execution plan.
--     Identify the join algorithm or algorithms used, such as Nested Loop, Hash Join, or Merge Join.
--     Explain why PostgreSQL may have selected these algorithms, considering table sizes and available indexes.
--     Predict which part of the query might become less efficient as the dataset grows.
--
-- You may also use EXPLAIN ANALYZE to measure actual execution behavior. Unlike EXPLAIN, it runs the query. It is appropriate for your read-only SELECT query, but use caution with statements that modify data.