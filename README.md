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
- Resources: A or B, reprensenting rows or tables being
processed.

### Isolation
- The order of concurrent transactions processed is called *serializable*.
- Isolation property requires that *serializable* transaction is protected against errors.
- To make it serializable, we need to use locks. There are 2 types of locks: shared and exclusive lock. Shared is commonly used when reading data while exclusive is used when writing data.

|                   | Shared lock  |  Exclusive lock   |
|-------------------|:------------:|:-----------------:|
| **Shared lock**   |     Yes      |        No         |
| **Exclusive lock**|      No      |        No         |

**Two-phase locking**

- To make transactions serializable, we need to obey specific rules
for setting and releasing locks.
- One of those rules is *two-phase locking*: For each transaction,
one phase for setting locks and one for releasing locks.

|          |     |             |
|----------|:---:|:-----------:|
| LOCK A   |     |   LOCK A    |
| LOCK B   |     |   READ A    |
| READ A   |     |   WRITE A   |
| READ B   |     |   UNLOCK A  |
| WRITE A  |     |   LOCK B    |
| WRITE B  |     |   READ B    | 
| UNLOCK A |     |   WRITE B   |
| UNLOCK B |     |   UNLOCK B  |

**Locking granularity**

- The extent of to which resources are locked is referred to as
*granularity*.
- Fine granularity: Locking in units of rows (when a few resources are
locked).
- Coarse granularity: Locking in units of table (when many resources
are locked at once). 
- Because granularity is coarse, the number of locks per transaction
is reduced, leading to fewer processes on the CPU. On the other hand,
as resources are more, it takes longer to wait for other resource
to unlock, leading to fewer transactions being processed.
- In contrast, when granularity is fine, the number of locks per 
transaction increases, leading to higher loads on the CPU.However,
since resources are few, the time takes to process resources is smaller.
This leads more transactions being processed.

**Other concurreny controls**

- Using locks increases the burden of lock management =>
deadlocks, where users action conflict occur.
- Simpler method for concurreny controls when you have small
number of transactions or a high number of read operations.
  - **Timestamp control**: If a transaction with a later timestamp
  has already updated the data, current operation is cancelled.
  When a read or write operation is cancelled, the transaction is 
  rolled back.
  - **Optimistic control**: allows a read operation. When a write
  operation is performed, the data is checked to see if any other
  write operation has updated the data. If yes, the transaction is 
  rolled back.

**Levels of isolation**

- `SET TRANSACTION ISOLATION LEVEL ...`
  - `READ UNCOMMITED`: dirty read: possible, non-repeatable read: 
  possible, phantom read: possible.
  - `READ COMMITED`: dirty read: not possible, non-repeatable read: 
  possible, phantom read: possible.
  - `REPEATABLE READ`: dirty read: not possible, non-repeatable read: 
  not possible, phantom read: possible.
  - `SERIALIZABLE`: dirty read: not possible, non-repeatable read: 
  not possible, phantom read: not possible.
- *Dirty read*: transaction 2 reads a row before transaction 1 commits.
- *Non-repeatable read*: transaction read the same data twice and gets
a different value each.
- *Phantom read*: transaction reads the wrong row because another
transaction has changed the data.

### Durability

- Ensure security
- `GRANT <privilege> ON <table_name> TO <mysql_user> (WITH GRANT
OPTION);`
- `REVOKE <privilege> ON <table_name> TO <mysql_user>;`
- These privileges can be granted on a view.

## Failures
- Transaction failure: when a transaction cannot complete due to the
errors in transaction itself. This transaction is rolled back.
- System failure: when a power failure occurs,
  - If a transaction is commited before failure occurs, it is rolled
  forward.
  - If a transaction is **not** commited before failure occurs,
  it is rolled back.
- Media failure: when hard disk is damaged => use backup files =>
transactions that are commited before backup is rolled forward.

### Checkpoint
- To create efficiency, checkpoint is when a buffer's and a database's data are synchronized.

## Indexes
- *Index*: a tool which allows for speedily access to the location of target data, with fast results.
- **B-index**: all nodes are sorted. Then from the original node,
construct a parent node such that for each new node, the index
is the maximum of the original "group".
- **Hash index**: target data is hashed by a hash function, becoming
a unique fingerprint for a value => index.

## Optimizing a Query
- For selection, use full-match search or index-based search.
- For join, 
  - Nested loops (one row vs many other rows)
  - Sort merge (sort then search)
  - Hash (hash from one value to another)

## Optimizer
- In a database, a function that handles optimization of queries is
called **optimizer**. Two common types,
  - **Rule-based processing**: calculate the best way to
  optimize time.
  - **Cost-based processing**: calculate the best way using
  database's statistics, which take time to manage.

## Stored procedures
- **Stored procedure**: program that does not return values
from processing procedure.
- **Stored function**: program that returns values
from processsing procedure.
- **Trigger**: program that automatically runs when
before or after an operation on database.

## Distributed database
- **Horizontal distribution**: several instances (peers) of a database.
(failure-resistant system by design).
- **Vertical distribution**: assign different functions to different
servers. => heavy load on a main server.

## Partitioning data

- Data is spread across servers for storage in a distributed database
system.
- **Horizontal paritition**: data is splitted into units of rows
where different instances of database can share the same, related data
across the same server.
- **Vertical partition**: data is splitted into units of columns
where different instances share different data across different 
servers.

## Two-phase commit

- Is necessary to achieve atomicity as database is distributed
across the servers: one commit from all successful commits for all
instances.
- Involves a *coordinator* and *participants*. In the first phase,
the coordinator asks if a commit is possible for all participants,
who sends an OK if it is. In the second phase, the participants
complete each of their operation as instructed.
  - If all succeeds, then transaction is commit.
  - If all fails, then transaction is rolled back for all.

## Database replication

- Primary is called *master*, copy is called *replica*
- Types:
  - Read-only
  - Replication enabled for all: all servers access to a master.

