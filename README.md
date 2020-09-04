# sqlexercise

busStation.sql

getTimeTraveled(start_station varchar(20), bus_number integer)

inputs: 
start_station: the starting station of the bus
bus_number: bus number

returns:

a table of buses corresponding to bus_number along with total time traveled from start_station and time until next station

busNumber: bus number
station: station
totalTravelTime: total travel time from the starting station to current station
timeToNextStation: time until next station

employees.sql

returnAllEmployeesUnder(employee_name varchar(20), manager_id integer)

inputs:
employee_name: name of employee
manager_id: employee's manager id

returns:

a table of all employees under employee_name who has employee id of manager_id

employeeId: id of employee
firstName: first name of employee
lastName: last name of employee
