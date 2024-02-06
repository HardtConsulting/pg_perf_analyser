# pg_perf_analyser

This is a simple tool to analyse the performance of a PostgreSQL database. It creates a simple partitioned by range structure for users sending messages to each other. It provides initial seeding & then runs a variety of different tests and performance metrics to analyse the performance of the database.

## Getting Started

### Prerequisites
- Docker
- Docker Compose

## Running the tests

You can use a database tool like pgadmin to connect to the local instance and run the following queries to analyse the performance of the database.

```sql
-- QUERY 1:
SELECT * FROM get_messages_partition_stats();
```