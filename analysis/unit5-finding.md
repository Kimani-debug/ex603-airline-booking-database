In /analysis/unit5-finding.md.

In Task 5.3, you examined the execution plan for your three-table join. Reflect on the following question: What changes to your data or database schema might cause PostgreSQL to choose a different join algorithm?

Consider factors such as table size, indexes, and the number of matching records. Explain how these changes could influence query performance. Include your reflection in /analysis/unit5.md.

Based on the data, The flights that fail often are the flight id 7 with an origin country of Thailand & flight id 9 with an origin country of Singapore. While they have the most cancellations the two that have no booking are flight id 14 & 15 they 
flight from Vietname and Thailand. 

    Changes to the database scheme that could cause PostgreSQL to choose a difference join algorithm would be the length of a query table. The tables that were
