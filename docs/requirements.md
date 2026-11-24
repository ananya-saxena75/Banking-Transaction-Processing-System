#**Functional and Non-Functional Requirements**

##1. Functional Requirements
###The system shall:

ID	  Requirement
FR-1	Maintain customers, accounts, balances, account status and transaction history.
FR-2	Support deposit, withdrawal and account-to-account transfer.
FR-3	Reject invalid accounts, invalid amounts, inactive accounts and insufficient-balance transactions.
FR-4	Prevent duplicate processing using a unique transaction ID and idempotent processing.
FR-5	Record successful, failed and rejected transactions with an auditable reason.
FR-6	Maintain a processing audit trail and failure details for investigation.
FR-7	Provide these reports: (1) top 10 accounts by transaction volume, (2) failed transactions grouped by reason, (3) daily transaction amount by transaction type, (4) accounts with more than N transactions, (5) complete transaction history for a customer.
FR-8	Process transactions concurrently using a bounded thread pool.
FR-9	Use custom exceptions such as InsufficientBalanceException, AccountNotFoundException, DuplicateTransactionException and InvalidTransactionException.

##2. Non-Functional Requirements
###The system shall:

ID	    Requirement
NFR-1	  Concurrency safety: Ensure that simultaneous operations on the same account cannot corrupt its balance.
NFR-2	  Transaction boundaries and locking: Use explicit database transaction boundaries for monetary operations. Implement pessimistic locking, optimistic locking or an atomic SQL update, and document why the selected approach prevents lost updates, dirty outcomes and negative balances.
NFR-3	  Deadlock risk: Apply a deterministic account-locking order for transfers to reduce deadlock risk.
NFR-4	  Idempotency: Enforce idempotency through both application logic and a database uniqueness constraint, and demonstrate the behavior with an automated test.
NFR-5	  Logging: Use SLF4J with Logback or Log4j2. Log timestamp, transaction ID, relevant account identifier, thread, operation, result, duration and error category. Use DEBUG, INFO, WARN and ERROR appropriately.
NFR-6	  Log confidentiality: Avoid logging credentials, full sensitive account data or other unnecessary confidential information.
NFR-7	  SQL and database design: Create normalized DDL with primary keys, foreign keys, check constraints and unique constraints. Create and justify appropriate indexes. Write joins, aggregates, grouping, filtering and transactional SQL. Analyze at least three important queries using EXPLAIN or EXPLAIN ANALYZE and document observations.
NFR-8	  Performance: Generate at least 50,000 transactions and execute comparable tests with 1, 5, 10 and 20 worker threads. Capture total processing time, successful and failed transactions, transactions per second and database-related bottlenecks. Explain why increasing the thread count may stop improving throughput.
NFR-9	  Testing: Provide unit and concurrency-focused integration tests using JUnit 5.
NFR-10	Java design: Maintain good Java design and code quality.
NFR-11	Documentation: Provide a README with setup, assumptions and run instructions.

##3. Technical Constraints
Java 17+, Maven or Gradle
PostgreSQL or MySQL
JDBC or Spring Data JPA
SLF4J + Logback/Log4j2
JUnit 5

##4. Acceptance Criteria
ID	  Criterion
AC-1	No balance corruption under concurrent execution.
AC-2	No successful withdrawal leaves an account with a negative balance.
AC-3	Duplicate transaction IDs do not cause duplicate financial impact.
AC-4	All failures have consistent status, reason and traceable logs.
AC-5	The project can be set up and demonstrated using the submitted README.
AC-6	Mandatory test scenario: an account has ₹10,000 while concurrent withdrawals of ₹7,000 and ₹5,000 arrive. Both must not succeed.
