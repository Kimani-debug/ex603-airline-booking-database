# Task 5.1: Connect Producers to Their Data
1. What feature or report on your platform could use the three-table join from Question 1? What information would it display?

2. Why is the junction table important for answering Question 2? What would make this analysis more difficult without it?

# Task 5.2: Find Records That Joins May Exckude
1. Which producers were excluded by the inner join? Report their identifiers.

2. What does it mean when a producer has no events? What are some possible explanations?

3. How could a report based only on an inner join give leadership an incomplete picture of the platform?

4. Why might leadership want to identify producers who have never been active?

5. What action could leadership take based on these findings?

# Task 5.3: Understanding Join Performance and Execution Plans
1. Give an example of when a Cartesian product could be useful on your platform, or explain why you would not need one.

2. Which join algorithms did PostgreSQL choose for your query?

3. What information in the execution plan helps explain those choices?

4. Why is it useful to understand the selected join algorithms?

5. What changes to the data or database might make another join algorithm more appropriate?