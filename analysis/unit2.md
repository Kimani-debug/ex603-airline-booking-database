The constraints table
One row per foreign key. Three columns: the foreign key, the ON DELETE choice, and the reason in one sentence. Then, below the table, expand on the choices in prose:

|        Foreign Key         | ON DELETE Choice   | reason                                                                                                                                                 |
| -------------------------- | ------------------ | --------                                                                                                                                               |
| bookings.flight_id         | ON DELETE SET NULL | In the event that a flight is cancelled and removed from the flights table. The child row will return null to show the passengers that booked on the cancelled flight.|
| bookings.passenger_id      | ON DELETE CASCADE | If the passenger cancels cancels the flight ticket the passenger will be removed from the bookings table.|
| flight_routes.flight       | ON DELETE CASCADE | If the flight is cancelled from the flights.flight_id table the child row will be deleted as well since the route isn't active.|
| flight_routes.airport_name | ON DELETE CASCADE | When the airport is no longer servicing flights it will be removed from the child row in flight_routes to reflect that it is an unavailable airport for flight routes. |

For each ON DELETE choice, describe the real event it governs. What actually happens on your platform when a producer is removed? Name who or what is affected by the choice you made, and what would go wrong under the alternative.



The CHECK constraints
For each CHECK constraint, describe the invalid state it makes unstorable and how that state could otherwise arise.