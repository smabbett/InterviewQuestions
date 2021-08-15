/******************************************************
********Tables to pull from for this report************
*******************************************************
Payroll (EmployeeId INT, Paycode VARCHAR(100), Hours DECIMAL(12, 4), Rate DECIMAL(12, 4), FlatAmount DECIMAL(12, 4))
Employees (Employee VARCHAR(100), EmployeeId INT)
*/

CREATE PROCEDURE PayrollSummary
AS
SELECT Employee, Paycode, sum(p.Hours * p.Rate + p.FlatAmount) as Total from Payroll as p
inner join Employees as e
on e.EmployeeId = p.EmployeeId

group by e.Employee,p.Paycode

-- group by rollup (employee)

GO



-- EXEC PayrollSummary