Table Passengers {
  passenger_id integer [primary key]
  first_name varchar [not null]
  last_name varchar [not null]
  date_of_birth date [not null]
  email varchar [not null]
  created_at timestamp
}

Table Flights {
  flight_id integer [pk]
  departure_location varchar [not null]
  arrival_location varchar [not null]
  departure_time time
  arrival_time time
  airport_name varchar
  created_at timestamp
}

Table Bookings {
  booking_id integer [primary key]
  flight_id integer [not null, ref: > "Flights"."flight_id"]
  passenger_id  integer [not null, ref: > "Passengers"."passenger_id"]
  fare_paid integer
  created_at timestamp
}

Table Airports {
  airport_id integer [pk]
  airport_name varchar [pk]
}

Table Flight_Routes{
  flightroute_id integer [primary key]
  airports integer [not null, ref: > "Airports"."airport_id"]
  flights integer [not null, ref: > "Flights"."flight_id"]
}