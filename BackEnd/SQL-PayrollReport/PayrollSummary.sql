/******************************************************
********Tables to pull from for this report************
*******************************************************
Payroll (EmployeeId INT, Paycode VARCHAR(100), Hours DECIMAL(12, 4), Rate DECIMAL(12, 4), FlatAmount DECIMAL(12, 4))
Employees (Employee VARCHAR(100), EmployeeId INT)
*/

CREATE PROCEDURE PayrollSummary
AS
SELECT Employee = ISNULL( Employee, 'Total'), Paycode, SUM(Hours * Rate + FlatAmount) as Total from Payroll
inner join Employees
on Employees.EmployeeId = Payroll.EmployeeId
group by rollup (employee)

GO



EXEC PayrollSummary