-- Seed the user table with 10 000 random users
INSERT INTO public."user" (name, surname, created, "Active")
SELECT
    'Name_' || s.id AS name,
    'Surname_' || floor(random() * 10000) + 1 AS surname,
    NOW() - (random() * (365 * 24) * '1 hour'::interval) AS created,
    (random() > 0.5) AS "Active"
FROM generate_series(1, 10000) AS s(id);