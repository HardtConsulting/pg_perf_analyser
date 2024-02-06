CREATE TABLE public."user"
(
    id serial NOT NULL,
    name text NOT NULL,
    surname text NOT NULL,
    created timestamp with time zone NOT NULL DEFAULT NOW(),
    "Active" boolean NOT NULL DEFAULT true,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public."user"
    OWNER to postgres;

CREATE TYPE message_type AS ENUM ('text', 'image', 'video');
CREATE TYPE case_type AS ENUM ('Type A', 'Type B', 'Type C', 'Type D', 'Type E', 'Type F', 'Type G', 'Type H', 'Type I', 'Type J');

CREATE SEQUENCE message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1; 

CREATE TABLE public.message
(
    id bigint NOT NULL DEFAULT nextval('message_id_seq'::regclass),
    sender_id integer NOT NULL,
    receiver_id integer NOT NULL,
    time_stamp timestamp with time zone NOT NULL DEFAULT now(),
    m_type message_type NOT NULL,
    c_type case_type NOT NULL,
    location text,
    field_a text,
    field_b text,
    field_c text,
    CONSTRAINT message_user_sender_id FOREIGN KEY (sender_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT message_user_receiver_id FOREIGN KEY (receiver_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
) PARTITION BY RANGE ("time_stamp");

ALTER TABLE IF EXISTS public.message
    OWNER to postgres;

CREATE INDEX idx_message_time_stamp_brin ON public.message USING BRIN (time_stamp);
CREATE INDEX idx_message_sender_id ON public.message USING btree (sender_id);
CREATE INDEX idx_message_receiver_id ON public.message USING btree (receiver_id);
CREATE INDEX idx_message_sender_receiver_time ON public.message USING btree (sender_id, receiver_id, time_stamp);
CREATE INDEX idx_message_c_type ON public.message USING btree (c_type);
CREATE INDEX idx_message_m_type ON public.message USING btree (m_type);

CREATE TABLE public.message_partition_y2020m01 PARTITION OF public.message FOR VALUES FROM ('2020-01-01') TO ('2020-02-01');
CREATE TABLE public.message_partition_y2020m02 PARTITION OF public.message FOR VALUES FROM ('2020-02-01') TO ('2020-03-01');
CREATE TABLE public.message_partition_y2020m03 PARTITION OF public.message FOR VALUES FROM ('2020-03-01') TO ('2020-04-01');
CREATE TABLE public.message_partition_y2020m04 PARTITION OF public.message FOR VALUES FROM ('2020-04-01') TO ('2020-05-01');
CREATE TABLE public.message_partition_y2020m05 PARTITION OF public.message FOR VALUES FROM ('2020-05-01') TO ('2020-06-01');
CREATE TABLE public.message_partition_y2020m06 PARTITION OF public.message FOR VALUES FROM ('2020-06-01') TO ('2020-07-01');
CREATE TABLE public.message_partition_y2020m07 PARTITION OF public.message FOR VALUES FROM ('2020-07-01') TO ('2020-08-01');
CREATE TABLE public.message_partition_y2020m08 PARTITION OF public.message FOR VALUES FROM ('2020-08-01') TO ('2020-09-01');
CREATE TABLE public.message_partition_y2020m09 PARTITION OF public.message FOR VALUES FROM ('2020-09-01') TO ('2020-10-01');
CREATE TABLE public.message_partition_y2020m10 PARTITION OF public.message FOR VALUES FROM ('2020-10-01') TO ('2020-11-01');
CREATE TABLE public.message_partition_y2020m11 PARTITION OF public.message FOR VALUES FROM ('2020-11-01') TO ('2020-12-01');
CREATE TABLE public.message_partition_y2020m12 PARTITION OF public.message FOR VALUES FROM ('2020-12-01') TO ('2021-01-01');
CREATE TABLE public.message_partition_y2021m01 PARTITION OF public.message FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');
CREATE TABLE public.message_partition_y2021m02 PARTITION OF public.message FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');
CREATE TABLE public.message_partition_y2021m03 PARTITION OF public.message FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');
CREATE TABLE public.message_partition_y2021m04 PARTITION OF public.message FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');
CREATE TABLE public.message_partition_y2021m05 PARTITION OF public.message FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');
CREATE TABLE public.message_partition_y2021m06 PARTITION OF public.message FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');
CREATE TABLE public.message_partition_y2021m07 PARTITION OF public.message FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');
CREATE TABLE public.message_partition_y2021m08 PARTITION OF public.message FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');
CREATE TABLE public.message_partition_y2021m09 PARTITION OF public.message FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');
CREATE TABLE public.message_partition_y2021m10 PARTITION OF public.message FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');
CREATE TABLE public.message_partition_y2021m11 PARTITION OF public.message FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');
CREATE TABLE public.message_partition_y2021m12 PARTITION OF public.message FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');
CREATE TABLE public.message_partition_y2022m01 PARTITION OF public.message FOR VALUES FROM ('2022-01-01') TO ('2022-02-01');
CREATE TABLE public.message_partition_y2022m02 PARTITION OF public.message FOR VALUES FROM ('2022-02-01') TO ('2022-03-01');
CREATE TABLE public.message_partition_y2022m03 PARTITION OF public.message FOR VALUES FROM ('2022-03-01') TO ('2022-04-01');
CREATE TABLE public.message_partition_y2022m04 PARTITION OF public.message FOR VALUES FROM ('2022-04-01') TO ('2022-05-01');
CREATE TABLE public.message_partition_y2022m05 PARTITION OF public.message FOR VALUES FROM ('2022-05-01') TO ('2022-06-01');
CREATE TABLE public.message_partition_y2022m06 PARTITION OF public.message FOR VALUES FROM ('2022-06-01') TO ('2022-07-01');
CREATE TABLE public.message_partition_y2022m07 PARTITION OF public.message FOR VALUES FROM ('2022-07-01') TO ('2022-08-01');
CREATE TABLE public.message_partition_y2022m08 PARTITION OF public.message FOR VALUES FROM ('2022-08-01') TO ('2022-09-01');
CREATE TABLE public.message_partition_y2022m09 PARTITION OF public.message FOR VALUES FROM ('2022-09-01') TO ('2022-10-01');
CREATE TABLE public.message_partition_y2022m10 PARTITION OF public.message FOR VALUES FROM ('2022-10-01') TO ('2022-11-01');
CREATE TABLE public.message_partition_y2022m11 PARTITION OF public.message FOR VALUES FROM ('2022-11-01') TO ('2022-12-01');
CREATE TABLE public.message_partition_y2022m12 PARTITION OF public.message FOR VALUES FROM ('2022-12-01') TO ('2023-01-01');
CREATE TABLE public.message_partition_y2023m01 PARTITION OF public.message FOR VALUES FROM ('2023-01-01') TO ('2023-02-01');
CREATE TABLE public.message_partition_y2023m02 PARTITION OF public.message FOR VALUES FROM ('2023-02-01') TO ('2023-03-01');
CREATE TABLE public.message_partition_y2023m03 PARTITION OF public.message FOR VALUES FROM ('2023-03-01') TO ('2023-04-01');
CREATE TABLE public.message_partition_y2023m04 PARTITION OF public.message FOR VALUES FROM ('2023-04-01') TO ('2023-05-01');
CREATE TABLE public.message_partition_y2023m05 PARTITION OF public.message FOR VALUES FROM ('2023-05-01') TO ('2023-06-01');
CREATE TABLE public.message_partition_y2023m06 PARTITION OF public.message FOR VALUES FROM ('2023-06-01') TO ('2023-07-01');
CREATE TABLE public.message_partition_y2023m07 PARTITION OF public.message FOR VALUES FROM ('2023-07-01') TO ('2023-08-01');
CREATE TABLE public.message_partition_y2023m08 PARTITION OF public.message FOR VALUES FROM ('2023-08-01') TO ('2023-09-01');
CREATE TABLE public.message_partition_y2023m09 PARTITION OF public.message FOR VALUES FROM ('2023-09-01') TO ('2023-10-01');
CREATE TABLE public.message_partition_y2023m10 PARTITION OF public.message FOR VALUES FROM ('2023-10-01') TO ('2023-11-01');
CREATE TABLE public.message_partition_y2023m11 PARTITION OF public.message FOR VALUES FROM ('2023-11-01') TO ('2023-12-01');
CREATE TABLE public.message_partition_y2023m12 PARTITION OF public.message FOR VALUES FROM ('2023-12-01') TO ('2024-01-01');
CREATE TABLE public.message_partition_y2024m01 PARTITION OF public.message FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');
CREATE TABLE public.message_partition_y2024m02 PARTITION OF public.message FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');
CREATE TABLE public.message_partition_y2024m03 PARTITION OF public.message FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');
CREATE TABLE public.message_partition_y2024m04 PARTITION OF public.message FOR VALUES FROM ('2024-04-01') TO ('2024-05-01');
CREATE TABLE public.message_partition_y2024m05 PARTITION OF public.message FOR VALUES FROM ('2024-05-01') TO ('2024-06-01');
CREATE TABLE public.message_partition_y2024m06 PARTITION OF public.message FOR VALUES FROM ('2024-06-01') TO ('2024-07-01');
CREATE TABLE public.message_partition_y2024m07 PARTITION OF public.message FOR VALUES FROM ('2024-07-01') TO ('2024-08-01');
CREATE TABLE public.message_partition_y2024m08 PARTITION OF public.message FOR VALUES FROM ('2024-08-01') TO ('2024-09-01');
CREATE TABLE public.message_partition_y2024m09 PARTITION OF public.message FOR VALUES FROM ('2024-09-01') TO ('2024-10-01');
CREATE TABLE public.message_partition_y2024m10 PARTITION OF public.message FOR VALUES FROM ('2024-10-01') TO ('2024-11-01');
CREATE TABLE public.message_partition_y2024m11 PARTITION OF public.message FOR VALUES FROM ('2024-11-01') TO ('2024-12-01');
CREATE TABLE public.message_partition_y2024m12 PARTITION OF public.message FOR VALUES FROM ('2024-12-01') TO ('2025-01-01');
CREATE TABLE public.message_partition_y2025m01 PARTITION OF public.message FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');
CREATE TABLE public.message_partition_y2025m02 PARTITION OF public.message FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');
CREATE TABLE public.message_partition_y2025m03 PARTITION OF public.message FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');
CREATE TABLE public.message_partition_y2025m04 PARTITION OF public.message FOR VALUES FROM ('2025-04-01') TO ('2025-05-01');
CREATE TABLE public.message_partition_y2025m05 PARTITION OF public.message FOR VALUES FROM ('2025-05-01') TO ('2025-06-01');
CREATE TABLE public.message_partition_y2025m06 PARTITION OF public.message FOR VALUES FROM ('2025-06-01') TO ('2025-07-01');
CREATE TABLE public.message_partition_y2025m07 PARTITION OF public.message FOR VALUES FROM ('2025-07-01') TO ('2025-08-01');
CREATE TABLE public.message_partition_y2025m08 PARTITION OF public.message FOR VALUES FROM ('2025-08-01') TO ('2025-09-01');
CREATE TABLE public.message_partition_y2025m09 PARTITION OF public.message FOR VALUES FROM ('2025-09-01') TO ('2025-10-01');
CREATE TABLE public.message_partition_y2025m10 PARTITION OF public.message FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');
CREATE TABLE public.message_partition_y2025m11 PARTITION OF public.message FOR VALUES FROM ('2025-11-01') TO ('2025-12-01');
CREATE TABLE public.message_partition_y2025m12 PARTITION OF public.message FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');

CREATE OR REPLACE FUNCTION message_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF pg_trigger_depth() <> 1 THEN
        RETURN NEW;
    END IF;

    -- 2020
    IF (NEW.time_stamp >= DATE '2020-01-01' AND NEW.time_stamp < DATE '2020-02-01') THEN
        INSERT INTO public.message_partition_y2020m01 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2020-02-01' AND NEW.time_stamp < DATE '2020-03-01') THEN
        INSERT INTO public.message_partition_y2020m02 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2020-03-01' AND NEW.time_stamp < DATE '2020-04-01') THEN
        INSERT INTO public.message_partition_y2020m03 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2020-04-01' AND NEW.time_stamp < DATE '2020-05-01') THEN
        INSERT INTO public.message_partition_y2020m04 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2020-05-01' AND NEW.time_stamp < DATE '2020-06-01') THEN
        INSERT INTO public.message_partition_y2020m05 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2020-06-01' AND NEW.time_stamp < DATE '2020-07-01') THEN
        INSERT INTO public.message_partition_y2020m06 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2020-07-01' AND NEW.time_stamp < DATE '2020-08-01') THEN
        INSERT INTO public.message_partition_y2020m07 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2020-08-01' AND NEW.time_stamp < DATE '2020-09-01') THEN
        INSERT INTO public.message_partition_y2020m08 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2020-09-01' AND NEW.time_stamp < DATE '2020-10-01') THEN
        INSERT INTO public.message_partition_y2020m09 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2020-10-01' AND NEW.time_stamp < DATE '2020-11-01') THEN
        INSERT INTO public.message_partition_y2020m10 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2020-11-01' AND NEW.time_stamp < DATE '2020-12-01') THEN
        INSERT INTO public.message_partition_y2020m11 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2020-12-01' AND NEW.time_stamp < DATE '2021-01-01') THEN
        INSERT INTO public.message_partition_y2020m12 VALUES (NEW.*);

    -- 2021
    ELSIF (NEW.time_stamp >= DATE '2021-01-01' AND NEW.time_stamp < DATE '2021-02-01') THEN
        INSERT INTO public.message_partition_y2021m01 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2021-02-01' AND NEW.time_stamp < DATE '2021-03-01') THEN
        INSERT INTO public.message_partition_y2021m02 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2021-03-01' AND NEW.time_stamp < DATE '2021-04-01') THEN
        INSERT INTO public.message_partition_y2021m03 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2021-04-01' AND NEW.time_stamp < DATE '2021-05-01') THEN
        INSERT INTO public.message_partition_y2021m04 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2021-05-01' AND NEW.time_stamp < DATE '2021-06-01') THEN
        INSERT INTO public.message_partition_y2021m05 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2021-06-01' AND NEW.time_stamp < DATE '2021-07-01') THEN
        INSERT INTO public.message_partition_y2021m06 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2021-07-01' AND NEW.time_stamp < DATE '2021-08-01') THEN
        INSERT INTO public.message_partition_y2021m07 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2021-08-01' AND NEW.time_stamp < DATE '2021-09-01') THEN
        INSERT INTO public.message_partition_y2021m08 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2021-09-01' AND NEW.time_stamp < DATE '2021-10-01') THEN
        INSERT INTO public.message_partition_y2021m09 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2021-10-01' AND NEW.time_stamp < DATE '2021-11-01') THEN
        INSERT INTO public.message_partition_y2021m10 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2021-11-01' AND NEW.time_stamp < DATE '2021-12-01') THEN
        INSERT INTO public.message_partition_y2021m11 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2021-12-01' AND NEW.time_stamp < DATE '2022-01-01') THEN
        INSERT INTO public.message_partition_y2021m12 VALUES (NEW.*);

    -- 2022
    ELSIF (NEW.time_stamp >= DATE '2022-01-01' AND NEW.time_stamp < DATE '2022-02-01') THEN
        INSERT INTO public.message_partition_y2022m01 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2022-02-01' AND NEW.time_stamp < DATE '2022-03-01') THEN
        INSERT INTO public.message_partition_y2022m02 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2022-03-01' AND NEW.time_stamp < DATE '2022-04-01') THEN
        INSERT INTO public.message_partition_y2022m03 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2022-04-01' AND NEW.time_stamp < DATE '2022-05-01') THEN
        INSERT INTO public.message_partition_y2022m04 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2022-05-01' AND NEW.time_stamp < DATE '2022-06-01') THEN
        INSERT INTO public.message_partition_y2022m05 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2022-06-01' AND NEW.time_stamp < DATE '2022-07-01') THEN
        INSERT INTO public.message_partition_y2022m06 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2022-07-01' AND NEW.time_stamp < DATE '2022-08-01') THEN
        INSERT INTO public.message_partition_y2022m07 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2022-08-01' AND NEW.time_stamp < DATE '2022-09-01') THEN
        INSERT INTO public.message_partition_y2022m08 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2022-09-01' AND NEW.time_stamp < DATE '2022-10-01') THEN
        INSERT INTO public.message_partition_y2022m09 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2022-10-01' AND NEW.time_stamp < DATE '2022-11-01') THEN
        INSERT INTO public.message_partition_y2022m10 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2022-11-01' AND NEW.time_stamp < DATE '2022-12-01') THEN
        INSERT INTO public.message_partition_y2022m11 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2022-12-01' AND NEW.time_stamp < DATE '2023-01-01') THEN
        INSERT INTO public.message_partition_y2022m12 VALUES (NEW.*);

    -- 2023
    ELSIF (NEW.time_stamp >= DATE '2023-01-01' AND NEW.time_stamp < DATE '2023-02-01') THEN
        INSERT INTO public.message_partition_y2023m01 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2023-02-01' AND NEW.time_stamp < DATE '2023-03-01') THEN
        INSERT INTO public.message_partition_y2023m02 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2023-03-01' AND NEW.time_stamp < DATE '2023-04-01') THEN
        INSERT INTO public.message_partition_y2023m03 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2023-04-01' AND NEW.time_stamp < DATE '2023-05-01') THEN
        INSERT INTO public.message_partition_y2023m04 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2023-05-01' AND NEW.time_stamp < DATE '2023-06-01') THEN
        INSERT INTO public.message_partition_y2023m05 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2023-06-01' AND NEW.time_stamp < DATE '2023-07-01') THEN
        INSERT INTO public.message_partition_y2023m06 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2023-07-01' AND NEW.time_stamp < DATE '2023-08-01') THEN
        INSERT INTO public.message_partition_y2023m07 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2023-08-01' AND NEW.time_stamp < DATE '2023-09-01') THEN
        INSERT INTO public.message_partition_y2023m08 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2023-09-01' AND NEW.time_stamp < DATE '2023-10-01') THEN
        INSERT INTO public.message_partition_y2023m09 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2023-10-01' AND NEW.time_stamp < DATE '2023-11-01') THEN
        INSERT INTO public.message_partition_y2023m10 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2023-11-01' AND NEW.time_stamp < DATE '2023-12-01') THEN
        INSERT INTO public.message_partition_y2023m11 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2023-12-01' AND NEW.time_stamp < DATE '2024-01-01') THEN
        INSERT INTO public.message_partition_y2023m12 VALUES (NEW.*);

    -- 2024
    ELSIF (NEW.time_stamp >= DATE '2024-01-01' AND NEW.time_stamp < DATE '2024-02-01') THEN
        INSERT INTO public.message_partition_y2024m01 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2024-02-01' AND NEW.time_stamp < DATE '2024-03-01') THEN
        INSERT INTO public.message_partition_y2024m02 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2024-03-01' AND NEW.time_stamp < DATE '2024-04-01') THEN
        INSERT INTO public.message_partition_y2024m03 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2024-04-01' AND NEW.time_stamp < DATE '2024-05-01') THEN
        INSERT INTO public.message_partition_y2024m04 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2024-05-01' AND NEW.time_stamp < DATE '2024-06-01') THEN
        INSERT INTO public.message_partition_y2024m05 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2024-06-01' AND NEW.time_stamp < DATE '2024-07-01') THEN
        INSERT INTO public.message_partition_y2024m06 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2024-07-01' AND NEW.time_stamp < DATE '2024-08-01') THEN
        INSERT INTO public.message_partition_y2024m07 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2024-08-01' AND NEW.time_stamp < DATE '2024-09-01') THEN
        INSERT INTO public.message_partition_y2024m08 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2024-09-01' AND NEW.time_stamp < DATE '2024-10-01') THEN
        INSERT INTO public.message_partition_y2024m09 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2024-10-01' AND NEW.time_stamp < DATE '2024-11-01') THEN
        INSERT INTO public.message_partition_y2024m10 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2024-11-01' AND NEW.time_stamp < DATE '2024-12-01') THEN
        INSERT INTO public.message_partition_y2024m11 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2024-12-01' AND NEW.time_stamp < DATE '2025-01-01') THEN
        INSERT INTO public.message_partition_y2024m12 VALUES (NEW.*);

    -- 2025
    ELSIF (NEW.time_stamp >= DATE '2025-01-01' AND NEW.time_stamp < DATE '2025-02-01') THEN
        INSERT INTO public.message_partition_y2025m01 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2025-02-01' AND NEW.time_stamp < DATE '2025-03-01') THEN
        INSERT INTO public.message_partition_y2025m02 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2025-03-01' AND NEW.time_stamp < DATE '2025-04-01') THEN
        INSERT INTO public.message_partition_y2025m03 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2025-04-01' AND NEW.time_stamp < DATE '2025-05-01') THEN
        INSERT INTO public.message_partition_y2025m04 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2025-05-01' AND NEW.time_stamp < DATE '2025-06-01') THEN
        INSERT INTO public.message_partition_y2025m05 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2025-06-01' AND NEW.time_stamp < DATE '2025-07-01') THEN
        INSERT INTO public.message_partition_y2025m06 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2025-07-01' AND NEW.time_stamp < DATE '2025-08-01') THEN
        INSERT INTO public.message_partition_y2025m07 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2025-08-01' AND NEW.time_stamp < DATE '2025-09-01') THEN
        INSERT INTO public.message_partition_y2025m08 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2025-09-01' AND NEW.time_stamp < DATE '2025-10-01') THEN
        INSERT INTO public.message_partition_y2025m09 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2025-10-01' AND NEW.time_stamp < DATE '2025-11-01') THEN
        INSERT INTO public.message_partition_y2025m10 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2025-11-01' AND NEW.time_stamp < DATE '2025-12-01') THEN
        INSERT INTO public.message_partition_y2025m11 VALUES (NEW.*);
    ELSIF (NEW.time_stamp >= DATE '2025-12-01' AND NEW.time_stamp < DATE '2026-01-01') THEN
        INSERT INTO public.message_partition_y2025m12 VALUES (NEW.*);

    ELSE
        RAISE EXCEPTION 'Date out of range. No partition for time_stamp %', NEW.time_stamp;
    END IF;
    
    RETURN NULL; -- Since this is an AFTER trigger
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_message_before_insert
BEFORE INSERT ON public.message
FOR EACH ROW EXECUTE FUNCTION message_insert_trigger();