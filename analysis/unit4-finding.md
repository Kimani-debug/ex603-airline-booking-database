## The breakdown

A short breakdown for the leadership team, in /analysis/unit4-finding.md. What is the true failure rate, how does it vary across producers, and which two or three producers would you actually investigate? Report by identifier. Write for a reader who does not write SQL.

Across all the data there were 200 bookings and 24 cancellations with a failure rate of 12%. Based on the country of origin Thailand had the most cancellations with 11 cancellations, and Singapore had the least with 4 cancellations. The two producers to investigate would be the top 2 countries with the highest cancellation, Thailand and Vietnam.

## Reflection (150–250 words)

Conditional aggregation computes several answers in one pass over the data. Contrast that with running two separate filtered queries. At a million rows, why does the difference matter?

With conditional aggregation, it is able to handle multiple actions within a query. An example of that would be the query in part A of 4.2 where a CASE WHEN statement is nested inside of a COUNT to gather all the bookings with the booking status of 'cancelled' and define the amount of booking failures. 

The size of a database can change the way it iswhen using certain functions because cost and time are important. Computing millions of rows one time would hurt, but for a growing database there are queries the run multiple times a day. Another issue would be accuracy of the data produced. 