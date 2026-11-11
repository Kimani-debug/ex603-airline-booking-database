--- Task 5.1
-- Who are the people behind the events?
-- Write a query that joins three tables to display the passengers who performed each bookings,
-- the flights associated with the bookings,
-- and the bookings date and time.

SELECT
    p.passenger_name,
    b.booked_at,
    f.flight_number
FROM bookings b
    JOIN passengers p ON b.passenger_id = p.passenger_id
    INNER JOIN flights f on f.flight_id = b.flight_id;

-- Do the flights identified in Assignment 4 share certain airport credentials or tags?
-- Write a query that connects the flights table to the airports table through the junction table.
-- Return the flights associated with your theme's catalog tag.
SELECT
    f.flight_number,
    a.iata_code
FROM flights f
    JOIN flight_routes fr ON f.flight_id = fr.flight_id
    JOIN airports a ON fr.airport_id = a.airport_id;


-- How do the flights compare with one another?
-- Write a self join to compare records within the flights table.
-- Use the results to explore whether the flights identified in Assignment 4 share characteristics with other producers
-- or whether differences in activity levels may explain their performance.

SELECT
    f.flight_id AS flight,
    f2.flight_id AS flight_2,
    f.origin_country AS active_oc
FROM flights f
    JOIN flights f2 ON f.origin_country = f2.origin_country;