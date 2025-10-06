USE AdventureWorksDW2019;

-- Indexid serveris
SELECT * FROM DimEmployee
-- Loome indeksi, mis aitab päringut: Loome indeksi Salary veerule.
CREATE INDEX IX_DimEmployee_BaseRate
ON DimEmployee(BaseRate ASC)
-- Kui soovid vaadata Indeksit
EXEC sp_help DimEmployee;
-- Kui soovid kustutada indeksit
DROP INDEX DimEmployee.IX_DimEmployee_BaseRate



-- Klastreeritud ja mitte-klastreeritud indeksid
-- Klastreeritud indeks dikteerib säilitatud andmete järjestuse tabelis ja seda saab klastreeritud puhul olla tabeli peale ainult üks. 
CREATE CLUSTERED INDEX IX_DimEmployee_FirstName
ON DimEmployee(FirstName)

-- Nüüd loome klastreeritud indeksi kahe veeruga
DROP INDEX DimEmployee.IX_DimEmployee_FirstName
-- Nüüd käivita järgnev kood uue klastreeritud ühendindeksi loomiseks Gender ja Salary veeru põhjal:
CREATE CLUSTERED INDEX IX_DimEmployee_Gender_BaseRate
ON DimEmployee(Gender DESC, BaseRate ASC)

-- Järgnev kood loob SQL-s mitte-klastreeritud indeksi Name veeru järgi tblEmployee tabelis
CREATE NONCLUSTERED INDEX IX_DimEmployee_FirstName
ON DimEmployee(FirstName)



-- Unikaalne ja mitte-unikaalne indeks
-- Kui soovid vaadata Indeksit
EXEC sp_helpindex DimEmployee;

-- Kuidas saab luua unikaalset mitte-klastreeritud indeksit FirstName ja LastName veeru põhjal
CREATE UNIQUE NONCLUSTERED INDEX UIX_DimEmployee_FirstName_LastName
On DimEmployee(FirstName, LastName)

--Kui peaksid lisama unikaalse piirangu, siis unikaalne indeks luuakse tagataustal. Selle tõestuseks lisame koodiga unikaalse piirangu City veerule.
ALTER TABLE DimEmployee 
ADD CONSTRAINT UQ_DimEmployee_Title
UNIQUE NONCLUSTERED (Title)
-- Käivita
EXECUTE SP_HELPCONSTRAINT DimEmployee

-- Kui soovin ainult viie rea tagasi lükkamist ja viie mitte korduva sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY valikut.
CREATE UNIQUE INDEX IX_DimEmployee_Title
ON DimEmployee(Title)
WITH IGNORE_DUP_KEY



-- Indeksi plussid ja miinused
-- Indeksist lähtuvalt on kergem üles otsida palkasid, mis jäävad vahemikku 4000 kuni 8000 ning kasutada reaaadressi.
SELECT * FROM DimEmployee WHERE BaseRate > 5 AND BaseRate < 10

-- Kui soovid uuendada või kustutada rida, siis SQL server peab esmalt leidma rea ja indeks saab aidata seda otsingut kiirendada.
DELETE FROM DimEmployee WHERE BaseRate = 9.50
UPDATE DimEmployee SET BaseRate = 50 WHERE BaseRate = 9.25
-- Käivita
SELECT * FROM DimEmployee

-- See välistab päringu käivitamisel ridade sorteerimise, mis oluliselt  suurendab  protsessiaega.
SELECT * FROM DimEmployee ORDER BY BaseRate

-- BaseRate veeru indeks saab aidata ka allpool olevat päringut. Seda tehakse indeksi tagurpidi skanneerimises.
SELECT * FROM DimEmployee ORDER BY BaseRate DESC

-- GROUP BY päringud saavad kasu indeksitest. Kui soovid grupeerida töötajaid sama palgaga, siis päringumootor saab kasutada BaseRate veeru indeksit
SELECT BaseRate, COUNT(BaseRate) AS Total
FROM DimEmployee
GROUP BY BaseRate