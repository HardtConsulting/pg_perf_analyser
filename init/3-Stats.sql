CREATE OR REPLACE FUNCTION get_messages_partition_stats()
RETURNS TABLE(
    partition_name text,
    row_count bigint,
    distinct_sender_ids bigint,
    distinct_receiver_ids bigint,
    average_time_diff interval
) AS $$
DECLARE
    partition text;
    query text;
BEGIN
    -- Ensure the loop iterates over partition names correctly
    FOR partition IN
        SELECT inhrelid::regclass::text
        FROM pg_inherits
        WHERE inhparent = 'public.message'::regclass
    LOOP
        -- Dynamically build the query for each partition
        query := format($f$
            WITH TimeDiffs AS (
                SELECT
                    sender_id,
                    receiver_id,
                    time_stamp - lag(time_stamp) OVER (ORDER BY time_stamp) AS time_diff
                FROM %I -- Use the partition identifier correctly
            )
            SELECT
                COUNT(*) AS row_count,
                COUNT(DISTINCT sender_id) AS distinct_sender_ids,
                COUNT(DISTINCT receiver_id) AS distinct_receiver_ids,
                AVG(time_diff) AS average_time_diff
            FROM TimeDiffs
        $f$, partition);

        -- Execute the built query and assign results to the function's return table structure
        EXECUTE query INTO row_count, distinct_sender_ids, distinct_receiver_ids, average_time_diff;
                          
        -- Set the partition name for the current row of the result set
        partition_name := partition;
        
        -- Return the current row of the result set
        RETURN NEXT;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_single_partition(start_ts timestamp, end_ts timestamp, partition_name text)
RETURNS SETOF message AS $$
DECLARE
    query text;
BEGIN
    query := format('SELECT * FROM %I WHERE time_stamp BETWEEN $1 AND $2', partition_name);
    RETURN QUERY EXECUTE query USING start_ts, end_ts;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_multiple_partitions(start_ts timestamp, end_ts timestamp)
RETURNS SETOF message AS $$
BEGIN
    RETURN QUERY SELECT * FROM message WHERE time_stamp BETWEEN start_ts AND end_ts;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_single_partition_sender(start_ts timestamp, end_ts timestamp, sender_id_param int, partition_name text)
RETURNS SETOF message AS $$
DECLARE
    query text;
BEGIN
    query := format('SELECT * FROM %I WHERE sender_id = $3 AND time_stamp BETWEEN $1 AND $2', partition_name);
    RETURN QUERY EXECUTE query USING start_ts, end_ts, sender_id_param;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_multiple_partitions_sender(start_ts timestamp, end_ts timestamp, sender_id_param int)
RETURNS SETOF message AS $$
BEGIN
    RETURN QUERY SELECT * FROM message WHERE sender_id = sender_id_param AND time_stamp BETWEEN start_ts AND end_ts;
END;
$$ LANGUAGE plpgsql;