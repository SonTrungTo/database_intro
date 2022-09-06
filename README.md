## This introduction covers Database Design
taken from 2 sources:
- [Udemy course in DB](https://www.udemy.com/course/the-ultimate-mysql-bootcamp-go-from-sql-beginner-to-expert)
- [Manga guide to DB](https://www.amazon.com/Manga-Guide-Databases-Mana-Takahashi/dp/1593271905/ref=sr_1_1?crid=1OZ4VQMG47RNR&keywords=manga+guide+to+databases&qid=1661751478&sprefix=manga+guide+to+%2Caps%2C146&sr=8-1)

## What is a Database?
- An entity that shares, manages and uses data.
- Without database, a system faces inefficiencies arising from:
  - Data duplication.
  - Difficulty in updating information.
  - Conflicting data within a system.
  - Increase in error-prone activities by human's interaction.

## Challenges a new system has to face
- It must share a standard query structure - easy to use.
- It must have security and permissions to prevent unauthorized data manipulation.
- It must have a mechanism to prevent data conflicts from simulatenous update.
- It must have recovery mechanism from external failures (Internal Server Errors).

## Database Terminology
- **Record**: a piece of data. Each record contains fields of the same type.
- **Field**: each item in a record.
### Relational Database
- A table is called *relation*
- **Row** is a record.
- **Column** is a field.
### Set Operations vs Relational Operations
- Union, Difference, Intersection and Cartesian.
- Projection, Selection, Join and Division.

## E-R Model
- Entity and its relationship.
- **Normalization** is dividing one complex table into tables that
are easier to manage and update.
- Repeated data is a clue that rows have to be divided.
- Principle: Each primary key should uniquely identify a row.
- Foreign key refers to primary key in other tables.
- Number of associations between entities is called *cardinality*.
- A value is *functionally dependent* if it determines the value in other columns.
- A value is *transitively dependent* if it indirectly determines the value in other columns.
- Conceptual schema vs internal schema vs external schema.

## SQL
- Statements, phrases.
- `WHERE product_name LIKE '%n'` => retrieve product_name that ends with `n`.
- `WHERE product_name LIKE '_n'` => retrieve product_name that *after a character* with `n`.
- Aggregate functions: `COUNT(*), COUNT(col_name), COUNT(DISTINCT col_name), SUM(col_name), AVG(col_name), MAX(col_name), MIN(col_name)`
- Join Tables: `SELECT FROM WHERE`
- Create and Insert: `CREATE TABLES name(); INSERT INTO name() VALUES();`
- Delete and Update.
- Futher searches: `BETWEEN x1 AND x2` or `WHERE x1 is NULL`
- `GROUP BY ... HAVING`
- Sub-query vs Correlated query.

## Transactions
- A series of successful operations is called a transaction.
- A transaction must satisfy these properties (ACID) to protect against data inconsistencies:
  - Atomicity: a transaction must either end with **commit** or **rollback** operation.
  - Consistency: processing a transaction must never result in loss of "what-is-supposed-to-be"
  before and after the transaction.
  - Isolation: the result of a transaction applied concurrently must be the same
  as that in sequential processing.
  - Durability: The contents of a completed transaction is not affected by failure.
### Atomicity
All operations either succeeds or fails completely. If succeeds, COMMIT. If fails, ROLLBACK.

``
COMMIT;
``

``
ROLLBACK;
``

### Consistency
- Database must be consistent before and after a transaction occurs.
- Beware of *lost update*, where a concurreny transaction is cancelled if another concurrent transaction is taking place.
- All database must have access to the same resource without creating errors.

### Isolation
- The order of concurrent transactions processed is called *serializable*.
- Isolation property requires that *serializable* transaction is protected against errors.
- To make it serializable, we need to use locks. There are 2 types of locks: shared and exclusive lock. Shared is commonly used when reading data while exclusive is used when writing data.

|                   | Shared lock  |  Exclusive lock   |
|-------------------|:------------:|:-----------------:|
| **Shared lock**   |     Yes      |        No         |
| **Exclusive lock**|      No      |        No         |
