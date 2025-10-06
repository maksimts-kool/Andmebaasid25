USE AdventureWorksDW2019;

select * from DimEmployee
select * from DimDepartmentGroup

-- View serveris
-- Selleks, et saada soovitud tulemus, me peaksime �hendama kaks tabelit omavahel
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup 
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey

-- N��d loome view, kus kasutame JOIN-i
CREATE VIEW vWEmployeeByDepartment
AS
SELECT EmployeeKey, FirstName, BaseRate, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
-- K�ivita
SELECT * FROM vWEmployeeByDepartment

-- View, mis tagastab ainult Corporate osakonna t��tajad
CREATE VIEW vWCorporateDepartment_Employees
AS
SELECT EmployeeKey, FirstName, BaseRate, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
WHERE DimDepartmentGroup.DepartmentGroupName = 'Corporate'
-- K�ivita
SELECT * FROM vWCorporateDepartment_Employees

-- View, kus ei ole BaseRate veergu
CREATE VIEW vWEmployeesNonConfData
AS
SELECT EmployeeKey, FirstName, Gender, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
-- K�ivita
SELECT * FROM vWEmployeesNonConfData

-- View, mis tagastab summeeritud andmed t��tajate koondarvest.
CREATE VIEW vWEmployeesCountByDepartment
AS
SELECT DepartmentName, COUNT(DepartmentGroupKey) AS TotalEmployees
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
GROUP BY DepartmentName
-- K�ivita
SELECT * FROM vWEmployeesCountByDepartment

-- Kui soovid vaadata view definitsiooni
sp_helptext vWName
-- Kui soovid muuta view-d
ALTER VIEW
-- Kui soovid kustutada view-d 
DROP VIEW vWName



-- View uuendused
-- Teeme View, mis tagastab peaaegu k�ik veerud, aga va Salary veerg.
CREATE VIEW vWEmployeesDataExSalary
AS
SELECT EmployeeKey, FirstName, Gender, DepartmentName
FROM DimEmployee
-- K�ivita
SELECT * FROM vWEmployeesDataExSalary

-- J�rgnev p�ring uuendab Name veerus olevat nime Mike Mikey peale. 
UPDATE vWEmployeesDataExSalary
SET FirstName = 'Mikey' WHERE EmployeeKey = 2
-- K�ivita
SELECT * FROM DimEmployee

-- Loome view, mis �hendab kaks eelpool k�sitletud tabelit ja annab sellise tulemuse:Samas on v�imalik sisestada ja kustutada ridu baastabelis ning kasutada view-d.
DELETE FROM vWEmployeesDataExSalary WHERE EmployeeKey = 2
INSERT INTO vWEmployeesDataExSalary VALUES (2, 'Mikey', 'M', 2)

-- Loome view, mis �hendab kaks eelpool k�sitletud tabelit ja annab sellise tulemuse
CREATE VIEW vWEmployeeDetailsByDept
AS
SELECT EmployeeKey, FirstName, Gender, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
-- K�ivita
SELECT * FROM vWEmployeeDetailsByDept

-- N��d uuendame John osakonda HR pealt Corporate peale. Hetkel on kaks t��tajat HR osakonnas
UPDATE vWEmployeeDetailsByDept
SET DepartmentName = 'Corporate' WHERE FirstName = 'John'
-- K�ivita
SELECT * FROM DimEmployee