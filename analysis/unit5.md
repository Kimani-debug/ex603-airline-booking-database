# Task 5.1: Connect Producers to Their Data
1. What feature or report on your platform could use the three-table join from Question 1? What information would it display?

The three features in the platform are the passenger name, the time the passenger booked, and the flight number which displays information from the bookings table and passengers table.

2. Why is the junction table important for answering Question 2? What would make this analysis more difficult without it?
The junction table is important because it is able to show information from two different tables that have a relation based on id.

# Task 5.2: Find Records That Joins May Exckude
1. Which producers were excluded by the inner join? Report their identifiers.
Producers that have no matching data between two datasets. They are identified by their count. 

2. What does it mean when a producer has no events? What are some possible explanations?
A producer has no events when there are no bookings in the table against the flight chosen. 

3. How could a report based only on an inner join give leadership an incomplete picture of the platform?
A report based on an inner join can be false because it will disregard rowa that have no matching data. 

4. Why might leadership want to identify producers who have never been active?
Showing inactive users is beneficial when deciding what needs to be removed due to inactivity. 

5. What action could leadership take based on these findings?
Leadership should re-evalute the need for the two inactive routes since there are other flights that can cover it. 

# Task 5.3: Understanding Join Performance and Execution Plans
1. Give an example of when a Cartesian product could be useful on your platform, or explain why you would not need one.


2. Which join algorithms did PostgreSQL choose for your query?
It used the Hash join for bookings to passengers join, and a nested loop for the results.

3. What information in the execution plan helps explain those choices?
The section in the execution plan that is able to do a full scan of the bookings listing, and the memory usage in the hash table being 10kB.

4. Why is it useful to understand the selected join algorithms?
To understand how efficient a schema is running. To understand what queries are running slow.

5. What changes to the data or database might make another join algorithm more appropriate?

