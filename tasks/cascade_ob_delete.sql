START TRANSACTION;
USE aero;

DROP TABLE IF EXISTS trip_copy;
CREATE TABLE trip_copy LIKE Trip;

INSERT INTO trip_copy 
SELECT * FROM  Trip;

 
	
DROP TABLE IF EXISTS comp_copy;
CREATE TABLE comp_copy LIKE Company;

INSERT INTO comp_copy 
SELECT * FROM  Company;


ALTER TABLE trip_copy ADD 
	CONSTRAINT FK_Trip_Company_copy FOREIGN KEY 
	(
		ID_comp
	) REFERENCES comp_copy (
		ID_comp
	) ON DELETE CASCADE;

DESC trip_copy;
DESC comp_copy;

SELECT * FROM trip_copy;

DELETE FROM comp_copy WHERE ID_comp != 1;

SELECT * FROM trip_copy;
COMMIT;