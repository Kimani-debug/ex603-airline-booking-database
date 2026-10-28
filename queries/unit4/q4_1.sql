-- Task 4.1 — the baseline, per-producer, HAVING, and two-dimension queries.

-- Calculate the following statistics across the entire bookings table using your theme's metric fare paid:
-- the count, total, average, minimum, and maximum of your theme’s metric across the whole event table,
-- and how many distinct actors appear.

SELECT COUNT(fare_paid) AS fare_paid,
       SUM(fare_paid) AS fare_paid_total,
       AVG(fare_paid) AS fare_paid_average,
       MIN(fare_paid) AS fare_piad_min,
       MAX(fare_paid) AS fare_paid_max
FROM bookings;

-- Write a query that calculates the bookings count and average fare paid for each flights.
-- Sort the results from the flights with the most bookings to the flights with the fewest.
-- Consider what these results tell you about differences in activity and performance across producers.
SELECT flight_id,
       COUNT(flight_id) AS bookings_count,
       AVG(fare_paid) AS average_amount
FROM bookings
GROUP BY flight_id
ORDER BY bookings_count DESC ;


-- Which flights have enough volume for their rate to mean anything? A flights with only a few bookings may have
-- a high failure rate that is not representative of their usual performance. Choose a minimum bookings-count threshold
-- and use HAVING to include only flights who meet that threshold. Explain why you selected your threshold.
SELECT flight_id,
       COUNT(flight_id) AS bookings_count,
       AVG(fare_paid) AS average_amount
FROM bookings
GROUP BY flight_id
HAVING COUNT(flight_id) > 11
ORDER BY bookings_count DESC;

-- How does the picture change along two dimensions at once? Leadership also wants to understand how performance
-- varies across regions. Write a query that groups the data by two dimensions, including region, and calculates the
-- relevant summary statistics. Your results should contain one row for each combination of the two dimensions so that
-- regional leaders can review their results.

SELECT
    booking_country,
    booking_status,
    COUNT(flight_id) AS booking_count,
    AVG(fare_paid) AS average_amount
FROM bookings
GROUP BY booking_country, booking_status;