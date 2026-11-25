## Task 6.1
1. Write a question that needs each row shown next to its group’s average. Explain why the group average alone (GROUP BY) cannot answer it.

How much did people pay on each flight, and How much is the average price for a ticket on a flight? GROUP BY would collapse the flight_id's so it wouldn't be possible to see the indiviual price people paid to come to the conclusion of that average. 

2. Ranking is never neutral: someone is being ordered, and tie handling decides who counts as equal. Name a platform feature that would use your ranking, and explain which of the three functions it should use and why.

A flight platforma may use this ranking system when they are trying to find the flight that has the most passengers booked on it. 

## Task 6.2
1. What would a large delta tell someone about your platform, and what should they do about it?

A large delta would tell them that there is a price difference between the price that was paid on that current day vs the day before. In term of airline bookings it would tell them the best time or day of the week to buy.

2. Why does a running total answer a question that a plain SUM cannot?

A running total allows you to observe data over time where a SUM can only shows the collection of one piece of data such as the value of bookings over time vs the sum of a value from multiple bookings. 

3. Why did you pick your moving-average window size? A different size tells a different story.

I chose 30 days as a metric because evaluating prices within in a month span can show more valuable information than 2-3 weeks for airline fares. 

4. What does a gap mean in your platform: a data quality problem, a real stop in activity, or a side effect of how events were recorded? Each needs a different response. Say which one yours is and how you know.

In this dataset a gap represents a stop in ticket purchases fir the flight tied to that flight id. In reality flights are booked everyday but in this data set bookings are made randomly through 2023 for different flights.

## Task 6.3
7. Name the feature in your platform that top-N would power. Explain why three is the right number, rather than one or ten.

Top three is the best number to use because anything larger like 10 or small like 1 would be able to give a high level view of what to expect from the flight fare. See the 3 highest values is enough to know what's required to book. In terms of a booking site, there are usually at most 3 tiers shown for flight packages. For example, tiers like Basic, Economy, or Comfort so 3 is the best number in the scenario.

8. What would a large month-over-month change mean in your domain, and what should someone do about it? A number nobody acts on is not a metric.

A large month-over-month change would mean that the cost for a flight can change based on the month, and someone can interpret that as a popular month for the flights to a specfic destination or the opposite. 

## Task 6.4
Is the failure problem getting better or worse over the time your data covers? 

The failure problem is getting better based on the data that has been covered in this section. The month to month data shows a fluctuation in bookings each month but they are able to stay above 15 bookings a month.

What should the team do next quarter? Support every claim with a query you ran.

The team should most likely drop flight id's 14, and 15 whose origin country is Vietnam, and Thailand because both of them have a 0 boooking count. Also Market flight during March and April to increase booking numbers since they project the lowest during those months at 11 bookings.