README.md 



\# SQL Data Analysis \& Business Intelligence Project



A PostgreSQL-based database schema and analytical query suite designed to analyze sales, customer demographics, employee order processing, and inventory metrics.



\---



**## Data Architecture \& Tools Used**



\### Core Database System

\* \*\*RDBMS:\*\* PostgreSQL (Compatible with MySQL / SQLite with minor dialect adjustments)

\* \*\*Language:\*\* ANSI SQL / PL/pgSQL



\### **Key SQL Methods \& Concepts**



\* \*\*Relational Schema Design:\*\* Primary Keys (`SERIAL PRIMARY KEY`), Foreign Key constraints, and Cascade/Referential Integrity.

\* \*\*Complex Aggregations:\*\* `GROUP BY`, `HAVING`, and multi-attribute aggregate logic (`SUM`, `COUNT`, `AVG`, `MAX`).

\* \*\*Advanced Joins:\*\* `INNER JOIN`, `LEFT OUTER JOIN`, and multi-table relation chaining across up to 4 entities.

\* \*\*Subqueries \& CTEs:\*\* Correlated subqueries (`WHERE p1.stock > AVG(p2.stock)`), scalar subqueries, and Common Table Expressions (`WITH ... AS`).

\* \*\*Existential Filtering:\*\* Optimizing query performance using `EXISTS` and `NOT EXISTS` clauses instead of heavy `IN` / `NOT IN` subqueries.



\---



**## Database Schema Overview**



The database consists of 5 main tables:





1\. \*\*`customers`\*\*: Holds customer demography (`customer\_id`, `customer\_name`, `city`, `customer\_type`).

2\. \*\*`products`\*\*: Catalog details and inventory (`product\_id`, `product\_name`, `category`, `unit\_price`, `stock\_quantity`).

3\. \*\*`employees`\*\*: Staff hierarchy with self-referential manager mapping (`employee\_id`, `employee\_name`, `job\_title`, `manager\_id`).

4\. \*\*`orders`\*\*: Transaction header records (`order\_id`, `customer\_id`, `employee\_id`, `order\_date`, `order\_status`).

5\. \*\*`order\_items`\*\*: Line item detail mapping quantities to unit prices (`order\_item\_id`, `order\_id`, `product\_id`, `quantity`, `unit\_price`).



\---



**## Getting Started**



\### Prerequisites

\* PostgreSQL 12+ or any modern SQL Client (e.g., DBeaver, pgAdmin, DataGrip).



\### Installation \& Execution

1\. Clone this repository:

&#x20;  ```bash

&#x20;  git clone \[https://github.com/your-username/sql-class3-analysis.git](https://github.com/your-username/sql-class3-analysis.git)

&#x20;  cd sql-class3-analysis





├── README.md               # Executive summary, methodology, and challenge solutions

└── name\_sql\_class3.sql     # DDL, DML, assignment tasks, and business query script





=================================

**Final Business Challenge Analysis**

=================================



Below are the findings derived from the SQL analysis executed against the transaction ledger:



1\. Which product category generated the highest total revenue?

Category: Electronics



Total Revenue: ₦4,100,000.00



Insight: Driven largely by high unit-value items including Laptops and Smartphones.



2\. Which employee handled the highest number of completed orders?

Employee: Mathew Hindu



Completed Orders Handled: 3 orders (Order IDs #2, #7, and #9)



3\. Which city generated the highest total sales value?

City: Lagos



Total Sales Value: ₦4,280,000.00



4\. Which customer bought the largest total number of items?

Customer: Ada Stores



Total Quantity Purchased: 6 items (across Order IDs #1, #4, and #9)



5\. Which products were purchased by more than one different customer?

Products:



Smartphone (Purchased by Ada Stores and Chika Ventures)



Office Desk (Purchased by Bright Technologies and Ada Stores)



Air Conditioner (Purchased by Bright Technologies and Ada Stores)







=====================================================================



**Author**



**Andy Olisaemeka ==> emmeker@gmail.com**

