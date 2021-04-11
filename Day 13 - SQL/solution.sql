CREATE TABLE layers (
    depth integer,
    range integer
);

COPY layers FROM '$(pwd)/input.txt' DELIMITER ':' CSV;

-- Part 1:
SELECT SUM((depth % (range * 2 - 2)  = 0)::int * depth * range) FROM layers;

-- Part 2:
SELECT i from (
    SELECT i, (
        SELECT SUM(depth * range) severity from layers WHERE (depth + i ) % (range * 2 - 2) = 0
    )
    FROM generate_series(1, 1000000) i
) x WHERE severity IS NULL LIMIT 1;
