USE AdventureWorksDW2019;

select * from DimEmployee
select * from DimDepartmentGroup

-- View serveris
-- Selleks, et saada soovitud tulemus, me peaksime ühendama kaks tabelit omavahel
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup 
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey

-- Nüüd loome view, kus kasutame JOIN-i
CREATE VIEW vWEmployeeByDepartment
AS
SELECT EmployeeKey, FirstName, BaseRate, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
-- Käivita
SELECT * FROM vWEmployeeByDepartment

-- View, mis tagastab ainult Corporate osakonna töötajad
CREATE VIEW vWCorporateDepartment_Employees
AS
SELECT EmployeeKey, FirstName, BaseRate, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
WHERE DimDepartmentGroup.DepartmentGroupName = 'Corporate'
-- Käivita
SELECT * FROM vWCorporateDepartment_Employees

-- View, kus ei ole BaseRate veergu
CREATE VIEW vWEmployeesNonConfData
AS
SELECT EmployeeKey, FirstName, Gender, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
-- Käivita
SELECT * FROM vWEmployeesNonConfData

-- View, mis tagastab summeeritud andmed töötajate koondarvest.
CREATE VIEW vWEmployeesCountByDepartment
AS
SELECT DepartmentName, COUNT(DepartmentGroupKey) AS TotalEmployees
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
GROUP BY DepartmentName
-- Käivita
SELECT * FROM vWEmployeesCountByDepartment

-- Kui soovid vaadata view definitsiooni
sp_helptext vWName
-- Kui soovid muuta view-d
ALTER VIEW
-- Kui soovid kustutada view-d 
DROP VIEW vWName



-- View uuendused
-- Teeme View, mis tagastab peaaegu kõik veerud, aga va Salary veerg.
CREATE VIEW vWEmployeesDataExSalary
AS
SELECT EmployeeKey, FirstName, Gender, DepartmentName
FROM DimEmployee
-- Käivita
SELECT * FROM vWEmployeesDataExSalary

-- Järgnev päring uuendab Name veerus olevat nime Mike Mikey peale. 
UPDATE vWEmployeesDataExSalary
SET FirstName = 'Mikey' WHERE EmployeeKey = 2
-- Käivita
SELECT * FROM DimEmployee

-- Loome view, mis ühendab kaks eelpool käsitletud tabelit ja annab sellise tulemuse:Samas on võimalik sisestada ja kustutada ridu baastabelis ning kasutada view-d.
DELETE FROM vWEmployeesDataExSalary WHERE EmployeeKey = 2
INSERT INTO vWEmployeesDataExSalary VALUES (2, 'Mikey', 'M', 2)

-- Loome view, mis ühendab kaks eelpool käsitletud tabelit ja annab sellise tulemuse
CREATE VIEW vWEmployeeDetailsByDept
AS
SELECT EmployeeKey, FirstName, Gender, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
-- Käivita
SELECT * FROM vWEmployeeDetailsByDept

-- Nüüd uuendame John osakonda HR pealt Corporate peale. Hetkel on kaks töötajat HR osakonnas
UPDATE vWEmployeeDetailsByDept
SET DepartmentName = 'Corporate' WHERE FirstName = 'John'
-- Käivita
SELECT * FROM DimEmployee