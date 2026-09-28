-- =================================================================
-- EX 603 Assignment 2 — schema.sql
-- Theme: airline booking service
-- Author: Kimani M
-- Target: PostgreSQL 18
-- =================================================================
-- Reset. Reverse creation order, so no dependency blocks a drop.

DROP TABLE IF EXISTS passengers    CASCADE;
DROP TABLE IF EXISTS flights   CASCADE;
DROP TABLE IF EXISTS bookings   CASCADE;
DROP TABLE IF EXISTS airports   CASCADE;
DROP TABLE IF EXISTS flight_routes    CASCADE;

-- =================================================================
-- Actor: Passengers
-- =================================================================
CREATE TABLE passengers(
    passenger_id INT,
    first_name VARCHAR(256) NOT NULL,
    last_name VARCHAR(256) NOT NULL,
    date_of_birth DATE NOT NULL
        CHECK(date_of_birth >= '1920-01-01' AND date_of_birth <= current_date),
    email VARCHAR(256) NOT NULL,
    PRIMARY KEY (passenger_id)
);

-- =================================================================
-- Producer: flights
-- =================================================================
CREATE TABLE flights(
    flight_id INT,
    departure_location VARCHAR NOT NULL,
    arrival_location VARCHAR NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    airport_name VARCHAR(256) NOT NULL,
    PRIMARY KEY (flight_id)
);

-- =================================================================
-- Event: Bookings
-- =================================================================
CREATE TABLE bookings(
    booking_id INT,
    flight_id INT,
    passenger_id INT,
    fare_paid INT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id) ON DELETE CASCADE,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id) ON DELETE CASCADE
);

-- =================================================================
-- Catalog: Airports
-- =================================================================
CREATE TABLE airports(
    airport_id INT,
    airport_name VARCHAR(256) NOT NULL UNIQUE,
    airport_city VARCHAR(256) NOT NULL,
    airport_country VARCHAR(256) NOT NULL,
    PRIMARY KEY (airport_id)
);

-- =================================================================
-- Junction: Flight Routes
-- =================================================================
CREATE TABLE flight_routes(
    flight_route_id INT,
    flight INT,
    airport_name VARCHAR(256) NOT NULL,
    PRIMARY KEY (flight_route_id),
    FOREIGN KEY (flight) REFERENCES flights(flight_id) ON DELETE CASCADE,
    FOREIGN KEY (airport_name) REFERENCES airports(airport_name) ON DELETE CASCADE
);