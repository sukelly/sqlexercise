CREATE TABLE employeesTable (employeeId integer NOT NULL PRIMARY KEY, managerId integer REFERENCES employeesTable(employeeId), firstName varchar(30), lastName varchar(30));

INSERT INTO employeesTable VALUES (1, NULL, 'Margo', 'Stephenson');
INSERT INTO employeesTable VALUES (2, 1, 'Armani', 'Blundell');
INSERT INTO employeesTable VALUES (5, 1, 'Melvin', 'Sandler');
INSERT INTO employeesTable VALUES (12, 2, 'Aalia', 'Smyth');
INSERT INTO employeesTable VALUES (15, 2, 'Brook', 'Sandford');
INSERT INTO employeesTable VALUES (17, 5, 'Corinne', 'Barclay');
INSERT INTO employeesTable VALUES (19, 5, 'Charlie', 'Ball');
INSERT INTO employeesTable VALUES (22, 2, 'Aarav', 'Mason');
INSERT INTO employeesTable VALUES (27, 2, 'Ebrahim', 'Vazquez');
INSERT INTO employeesTable VALUES (31, 22, 'Calista', 'Seymour');

CREATE FUNCTION returnAllEmployeesUnder(employee_name varchar(20), manager_id integer) RETURNS TABLE (employeeId integer, firstName varchar(30), lastName varchar(30)) as $$

BEGIN
    RETURN QUERY (
            SELECT e.employeeId, e.firstName, e.lastName 
            FROM employeesTable e
            WHERE managerId = manager_id
        UNION ALL
            SELECT s.employeeId, s.firstName, s.lastName
            FROM employeesTable e, returnAllEmployeesUnder(e.firstName, e.employeeId) s
            WHERE e.managerId = manager_id
    );
END;

$$ LANGUAGE plpgsql;

SELECT * FROM returnAllEmployeesUnder('Margo', 1); 
SELECT * FROM returnAllEmployeesUnder('Armani', 2); 