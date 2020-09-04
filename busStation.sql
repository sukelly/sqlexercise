CREATE TABLE busSchedule ( busNumber integer, station varchar(20) NOT NULL, arrivalTime time NOT NULL );

INSERT INTO busSchedule VALUES (1, 'Sacramento', '8:00');
INSERT INTO busSchedule VALUES (1, 'Elk Grove', '8:35');
INSERT INTO busSchedule VALUES (1, 'Lodi', '9:00');
INSERT INTO busSchedule VALUES (1, 'Stockton', '9:25');
INSERT INTO busSchedule VALUES (1, 'Manteca', '9:45');
INSERT INTO busSchedule VALUES (1, 'Modesto', '10:20');

INSERT INTO busSchedule VALUES (2, 'Sacramento', '8:00');
INSERT INTO busSchedule VALUES (2, 'Stockton', '9:05');
INSERT INTO busSchedule VALUES (2, 'French Camp', '9:25');
INSERT INTO busSchedule VALUES (2, 'Lathrop', '9:40');
INSERT INTO busSchedule VALUES (2, 'Tracy', '10:00');

CREATE FUNCTION getTimeTraveled(start_station varchar(20), bus_number integer) RETURNS TABLE (busNumber integer, station varchar(20), totalTimeTraveled interval, timeToNextStation interval) as $$

DECLARE
    start_time time;
BEGIN
    SELECT bs.arrivalTime INTO start_time FROM busSchedule bs WHERE bs.busNumber = bus_number;
    RETURN QUERY (
        SELECT a.busNumber, a.station, a.arrivalTime - start_time, b.arrivalTime - a.arrivalTime 
        FROM ( SELECT ROW_NUMBER() OVER() AS row_id, * FROM busSchedule a WHERE a.busNumber = bus_number) AS a
               LEFT JOIN 
             ( SELECT ROW_NUMBER() OVER() AS row_id, * FROM busSchedule b WHERE b.busNumber = bus_number) AS b
               on a.row_id = b.row_id - 1
    );
END;

$$ LANGUAGE plpgsql;

SELECT * FROM getTimeTraveled('Sacramento', 1); 
SELECT * FROM getTimeTraveled('Sacramento', 2);