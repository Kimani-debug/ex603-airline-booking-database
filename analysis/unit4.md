
## Task 4.1 Write Up

The person who would act on the per-producer breakdown would be the stakeholder who are looking into the financial performace of the flights. The airlines themselves could also benefit from this information as well.

In the functions the total, average, min, and max amount of fares paid in the bookings table is shown. booking count per flight id is also calculated with the average fares of those groups. Since the flight_ids are grouped together it only presents the average fare amount per flight group. The average only shows the median cost of a flight ticket based on the flight_id, and each flight_id group is a set of flights from different origin countries. Results grouped by booking country for each flight would persent a more specific metric to evaulate.  

## Task 4.2 Write Up 

### For Part A, state the two questions your conditional aggregation answers side by side.

The two questions this aggregation answers and what is what is the total amount of failures within each flight id? and which flight_id group had the least/most amount of booking cancellations. 

### For Part B, name the reader who needs subtotals rather than detail rows, and say what decision the grand total supports that the group rows do not.

Individuals who aren't interested in understanding how the functions were aggregated, but want to see what the outcome of all transactionswere would be intered in subtotals instead. The grand total presents the overall failure rate, while the group rows break that down based on booking country. 

### For Part C, state the question the pipeline answers.

Which high volume flights combine the lowest cancellation rates with the highest average fares? 
