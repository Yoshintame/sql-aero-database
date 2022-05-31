START TRANSACTION;
USE aero;

ALTER TABLE Trip ADD COLUMN ID_comp_copy int(11);
UPDATE Trip
SET ID_comp_copy = ID_comp;

ALTER TABLE Trip ADD 
	CONSTRAINT FK_Trip_Company_Copy FOREIGN KEY 
	(
		ID_comp_copy
	) REFERENCES Company (
		ID_comp
	);

ALTER TABLE Trip DROP 
CONSTRAINT FK_Trip_Company;

ALTER TABLE Trip DROP COLUMN ID_comp;

SELECT ID_comp, ID_comp_copy, name
FROM Trip
JOIN Company ON Trip.ID_comp_copy = Company.ID_comp;

SELECT * FROM Trip;
COMMIT;