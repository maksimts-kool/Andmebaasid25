USE AdventureWorksDW2019

-- DLL Trigerid serveris
-- Süntaks loomaks DDL trigereid
CREATE TRIGGER [Trigger_Name]
ON [Scope(Server/Database)]
FOR [EventType1, EventType2, EventType3]
AS
BEGIN
-- Trigger Body
END

-- Järgnev trigger käivitab vastuseks CREATE_TABLE DDL sündmuse: sp_rename
CREATE TRIGGER FirstTrigger
ON Database
FOR CREATE_TABLE
AS
BEGIN
PRINT 'New table created'
END
-- Kui sa järgnevat koodi käivitad, siis trigger läheb automaatselt käima ja prindib välja sõnumi: uus tabel on loodud.
CREATE TABLE test (id INT)