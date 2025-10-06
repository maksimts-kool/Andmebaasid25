USE AdventureWorksDW2019;


-- funktsioonid 1
SELECT * FROM DimEmployee

-- Tabelisisev��rtusega funktsioon e Inline Table Valued function (ILTVF)
CREATE FUNCTION fn_ILTVF_GetEmployee()
RETURNS TABLE
AS
RETURN (SELECT EmployeeKey, FirstName, CAST(BirthDate AS Date) AS DOB
FROM DimEmployee)
-- K�ivita funktsiooni
SELECT * FROM fn_ILTVF_GetEmployee()

--  Mitme avaldisega tabeliv��rtusega funktsioonid e multi-statement table valued function (MSTVF)
CREATE FUNCTION fn_MSTVF_GetEmployee()
RETURNS @Table TABLE (EmployeeKey INT, FirstName NVARCHAR(20), DOB Date)
AS
BEGIN
INSERT INTO @Table
SELECT EmployeeKey, FirstName, CAST(BirthDate AS Date)
FROM DimEmployee
RETURN
END
-- K�ivita funktsiooni
SELECT * FROM fn_MSTVF_GetEmployee()

-- Uuendame allasuvat tabelit ja kasutame selleks ILTVF funktsiooni.
UPDATE fn_ILTVF_GetEmployee() SET FirstName = 'Guy2' WHERE EmployeeKey = 1



-- funktsioonid 2
-- Skaleeritav funktsioon ilma kr�pteerimata
CREATE FUNCTION fn_GetEmployeeNameById(@Id INT)
RETURNS NVARCHAR(20)
AS
BEGIN
RETURN (SELECT FirstName FROM DimEmployee WHERE EmployeeKey = @Id)
END
-- K�ivita funktsiooni
SELECT dbo.fn_GetEmployeeNameById(1);

-- N��d muudame funktsiooni ja kr�pteerime selle �ra
ALTER FUNCTION fn_GetEmployeeNameById(@Id INT)
RETURNS NVARCHAR(20)
WITH ENCRYPTION
AS
BEGIN
RETURN (SELECT FirstName FROM DimEmployee WHERE EmployeeKey = @Id)
END
-- K�ivita funktsiooni
SELECT dbo.fn_GetEmployeeNameById(1);

-- N��d muuda funktsiooni ja kasuta k�sklust WITH SCHEMABINDING valikut
ALTER FUNCTION fn_GetEmployeeNameById(@Id INT)
RETURNS NVARCHAR(20)
WITH SCHEMABINDING
AS
BEGIN
RETURN (SELECT FirstName FROM dbo.DimEmployee WHERE EmployeeKey = @Id)
END
-- K�ivita funktsiooni
SELECT dbo.fn_GetEmployeeNameById(1);

