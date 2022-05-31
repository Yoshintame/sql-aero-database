START TRANSACTION;

WITH Trip_with_dur AS (
    SELECT 
        CASE WHEN time_dep >= time_arr 
        THEN time_arr - time_dep + 1440 
        ELSE time_arr - time_dep END dur 
        , time_dep
        , trip_no
    FROM (
        SELECT 
            HOUR(time_out)*60 + MINUTE(time_out) time_dep
            , HOUR(time_in)*60 + MINUTE(time_in) time_arr
            , trip_no
        FROM Trip 
    ) tm
)

SELECT name 
FROM Passenger
WHERE ID_psg IN (
    SELECT ID_psg
    FROM Pass_in_trip 
    JOIN Trip_with_dur 
    ON  Pass_in_trip.trip_no = Trip_with_dur.trip_no
        AND DAYNAME(date) = 'Saturday'
        AND DAYNAME(DATE_ADD(date, INTERVAL (Trip_with_dur.time_dep + Trip_with_dur.dur) MINUTE)) = 'Sunday'
);

COMMIT;