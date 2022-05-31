START TRANSACTION;

SELECT name, trip_no, date
FROM    (SELECT 
            ROW_NUMBER() OVER (ORDER BY (date + time_out)) AS RowNum
            , date
            , ID_comp
            , Trip.trip_no
        FROM Pass_in_trip
        LEFT JOIN Trip ON Trip.trip_no = Pass_in_trip.trip_no
        WHERE   YEAR(date) = 2003 
            AND MONTH(date) = 4 
            AND town_from = 'Rostov') as num_table
INNER JOIN Company on Company.ID_comp = num_table.ID_comp
WHERE RowNum = 5;

COMMIT;