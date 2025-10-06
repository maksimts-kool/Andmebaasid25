USE AdventureWorksDW2019;

SELECT * FROM DimEmployee
-- Loome indeksi, mis aitab päringut: Loome indeksi Salary veerule.
CREATE INDEX IX_DimEmployee_BaseRate
ON DimEmployee(BaseRate ASC)