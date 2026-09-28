#The constraints table
##One row per foreign key. Three columns: the foreign key, the ON DELETE choice, and the ##reason in one sentence. Then, below the table, expand on the choices in prose:

|        Foreign Key         | ON DELETE Choice   | reason                                                                                                                                                 |
| -------------------------- | ------------------ | --------                                                                                                                                               |
| bookings.flight_id         | ON DELETE CASCADE | In the event that a flight is cancelled and removed from the flights table. The child row will return null to show the passengers that booked on the cancelled flight.|
| bookings.passenger_id      | ON DELETE CASCADE | If the passenger cancels cancels the flight ticket the passenger will be removed from the bookings table.|
| flight_routes.flight       | ON DELETE CASCADE | If the flight is cancelled from the flights.flight_id table the child row will be deleted as well since the route isn't active.|
| flight_routes.airport_name | ON DELETE CASCADE | When the airport is no longer servicing flights it will be removed from the child row in flight_routes to reflect that it is an unavailable airport for flight routes. |

#For each ON DELETE choice, describe the real event it governs. What actually happens on #your platform when a producer is removed? Name who or what is affected by the choice you #made, and what would go wrong under the alternative.

##Table bookings: FOREIGN KEY (flight_id) REFERENCES flights(flight_id) ON DELETE CASCADE:
Flight 4563 is having technical difficulties that results in a cancelled flight where the passengers removed from the booking then rebooked on another flight. Rows with the deleted flight_id will be removed from the bookings table and the rescheduled flights will be appear in the booking 

If the producer is removed it would also remove the passengers from the flight. If the flight_id is removed prematurely that could create issues with traceability of the people who were originally booked to the flight. 

##Tables bookings: FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id) ON DELETE CASCADE:
When a passenger cancels their flight ticket, the booking will be removed from the bookings row. If the producer is removed the passenger and airline are affect by the change. If the row isn't deleted it could cause issues with the flight capacity by incorrectly reflecting a flight as fully booked.  

##Table flight_routes: FOREIGN KEY (flight) REFERENCES flights(flight_id) ON DELETE CASCADE: 
Similar scenario to the flight_id foreign key in bookings. If the flight is cancelled the route associted with it is no longer a route on the table. 

If the producer is removed individuals who are looking for active flight routes when booking would see invalid flight routes to their destinations. 

##Table flight_routes: FOREIGN KEY (airport_name) REFERENCES airports(airport_name) ON DELETE CASCADE: 
A passenger is looking for flight routes departing from an airport in their city. They are able to only see airport options that are valid for their selected airport. 

This affects the passenger who is booking, if a flight is booked from an airport that isn't servicing an flights that could cause confusion if the passenger is able to book it. 

#The CHECK constraints
##For each CHECK constraint, describe the invalid state it makes unstorable and how that state could otherwise arise.

In passengers table: 
date_of_birth DATE NOT NULL
        CHECK(date_of_birth >= 1920-01-01 AND date_of_birth <= current_date)

The date_of_birth attribute is used to know the age of the passenger. On most UI some kind of calendar popup will appear for the user to add their date of birth. A date of birth set in a future date is invalid and unstorable because it wouldn't return a valid age.  