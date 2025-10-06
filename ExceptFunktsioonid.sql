USE AdventureWorksDW2019;

select * from DimEmployee
select * from DimCustomer

-- Except operaator tagastab unikaalsed read vasakust p�ringust.
SELECT EmployeeKey, FirstName, Gender
FROM DimEmployee
EXCEPT
SELECT CustomerKey, FirstName, Gender
FROM DimCustomer

-- Order by n�uet v�ib kasutada ainult kord peale paremat p�ringut
SELECT EmployeeKey, FirstName, Gender, BaseRate
FROM DimEmployee
WHERE BaseRate >= 10
EXCEPT
SELECT CustomerKey, FirstName, Gender, YearlyIncome
FROM DimCustomer
WHERE YearlyIncome >= 20000
ORDER BY FirstName



-- Erinevus Except ja not in operaatoril
-- Sama tulemuse v�ib saavutada NOT IN operaatoriga:
SELECT EmployeeKey, FirstName, Gender
FROM DimEmployee
WHERE EmployeeKey NOT IN (SELECT CustomerKey FROM DimCustomer)

-- Sisesta j�rgnev rida tabelisse TableA
INSERT INTO DimEmployee VALUES (1, 'Mark', 'Male')
-- N��d k�ivita j�rgnev EXCEPT p�ring
SELECT EmployeeKey, FirstName, Gender
FROM DimEmployee
EXCEPT
SELECT CustomerKey, FirstName, Gender
FROM DimCustomer
-- N��d k�ivita NOT IN operaatoriga kood
SELECT EmployeeKey, FirstName, Gender
FROM DimEmployee
WHERE EmployeeKey NOT IN (SELECT CustomerKey FROM DimCustomer)

-- J�rgnevas p�ringus on meelega veergude arv erinev
SELECT EmployeeKey, FirstName, Gender
FROM DimEmployee
EXCEPT
SELECT CustomerKey, FirstName
FROM DimCustomer

-- J�rgnevas p�ringus alamp�ring tagastab mitu veergu
SELECT EmployeeKey, FirstName, Gender
FROM DimEmployee
WHERE EmployeeKey NOT IN (SELECT CustomerKey, FirstName FROM DimCustomer)