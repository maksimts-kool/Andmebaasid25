USE AdventureWorksDW2019;
-- funktsioonid

SELECT * FROM DimEmployee

-- Tabelisisev‰‰rtusega funktsioon e Inline Table Valued function (ILTVF)
CREATE FUNCTION fn_ILTVF_GetEmployee()
RETURNS TABLE
AS
RETURN (SELECT EmployeeKey, FirstName, CAST(BirthDate AS Date) AS DOB
FROM DimEmployee)
-- K‰ivita funktsiooni
SELECT * FROM fn_ILTVF_GetEmployee()