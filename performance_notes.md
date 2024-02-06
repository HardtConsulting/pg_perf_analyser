Notes on performance:

- Use enums for types where possible / foreign key to master table and avoid using text / varchar fields for types.
- Structure all queries to include the partition keys in order to limit the set of sub-partitions to scan.
- Partition size can be relative arbitrary and should be chosen based on the expected size of the data and the expected number of records in the table to optimise the distribution.
- Add indices to all fields that are used in the WHERE clause of the queries except for the partition key.
- The lower the cardinality of a column, the less effective an index would be (i.e. try and logically split data on specifically defined types and then apply an index to evenly distribute the data).
- If the table is very large and the data has a naturally sequential order (like timestamps), a Block Range Index (BRIN) might be more space and performance efficient than a traditional B-tree index
- If there are common query patterns that involve filtering or sorting by sender_id, receiver_id, and timestamps (time_stamp), consider creating a composite index that matches these query patterns.
- If there's a common query pattern, you can use the CLUSTER command to physically reorder the table based on an index.
- Sequencing the primary key can result in slower inserts and it should be considered to abstract the sequencing by the inserting applications / alternatively use a hash approach to generate an ID for each row at the cost of a bit of storage.
