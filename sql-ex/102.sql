START TRANSACTION;

WITH full_table  AS (
    SELECT DISTINCT ID_psg, town_to, town_from
    FROM Pass_in_trip
    INNER JOIN (
        SELECT 
            trip_no
            ,CASE WHEN town_from > town_to
                THEN town_from ELSE town_to 
                END AS town_from
            ,CASE WHEN town_from < town_to
                THEN town_from ELSE town_to
                END AS town_to
        FROM Trip) AS uniqu 
    ON uniqu.trip_no = Pass_in_trip.trip_no
) -- сводная таблица trip и Pass_in_trip без дубликаты ранзых комбинаций одних и тех же городов для человека

SELECT name
FROM Passenger 
WHERE ID_psg IN (
    -- количество уникальных маршутов каждого человека = 1
    SELECT ID_psg 
    FROM full_table
    GROUP BY ID_psg 
    HAVING COUNT(town_to) = 1
);

COMMIT;