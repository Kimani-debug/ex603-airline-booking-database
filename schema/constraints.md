Write the constraints that protect your data. For each foreign key, state and justify the ON DELETE behavior:


Bookings(flight_id, passenger_id): ON DELETE SET NULL 
The booking history should be preserved if someone wants to look into the history of what someone booked. If passenger data or flight data is removed, the id will be null but the information still stays to show there is no active information in other tables; the remaining information remains if someone looks for it. 


Flight_Routes(airports, flights): ON DELETE RESTRICT
This table is used to show current flight route information for people who are booking. If the flight information is still active in the flights column, the information shouldn’t be removed from the table unless the flight has been canceled from the Flights table. 
