/******************************************************
********Tables to pull from for this report************
*******************************************************
Payroll (EmployeeId INT, Paycode VARCHAR(100), Hours DECIMAL(12, 4), Rate DECIMAL(12, 4), FlatAmount DECIMAL(12, 4))
Employees (Employee VARCHAR(100), EmployeeId INT)
*/

IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'PayrollSummary'
)
BEGIN
    DROP PROCEDURE PayrollSummary
END
GO
CREATE PROCEDURE PayrollSummary
AS
--doubles the amount for each row
SELECT Employee, Paycode, sum(p.Hours * p.Rate + p.FlatAmount) as Total 
from Payroll as p
join Employees as e
on e.EmployeeId = p.EmployeeId
group by e.Employee, p.Paycode
order by e.Employee

-- group by rollup (employee)

GO



-- EXEC PayrollSummary