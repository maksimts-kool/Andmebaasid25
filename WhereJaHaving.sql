USE AdventureWorksDW2019

SELECT * FROM DimProduct
-- Selleks, et arvutada kogu müüki toote pealt, siis peame kirjutama GROUP BY päringu
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName

-- Kui soovime ainult neid tooteid, kus müük kokku on suurem kui 1000€, siis kasutame filtreerimaks tooteid HAVING tingimust.
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName
HAVING SUM(SafetyStockLevel) > 800

-- Kui kasutame WHERE klasulit HAVING-u asemel, siis saame süntaksivea. 
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName
HAVING SUM(SafetyStockLevel) > 800

-- See näide pärib kõik read Sales tabelis, mis näitavad summat ning eemaldavad kõik tooted peale Chain-i ja Front Brakes.
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
WHERE EnglishProductName IN ('Chain', 'Front Brakes')
GROUP BY EnglishProductName

-- See näide pärib kõik read Sales tabelis, mis näitavad summat ning eemaldavad kõik tooted peale Chain-i ja Front Brakes.
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName
HAVING EnglishProductName IN ('Chain', 'Front Brakes')