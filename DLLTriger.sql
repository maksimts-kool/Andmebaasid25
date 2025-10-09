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

-- Kui soovid, et see trigger käivitatakse mitu korda nagu muuda ja kustuta tabel, siis eralda sündmused ning kasuta koma.
ALTER TRIGGER FirstTrigger 
ON Database
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
PRINT 'A table just been created, modified or deleted'
END
-- Kui nüüd lood, muudad ja kustutad tabeli, siis trigger käivitub automaatselt ja saad sõnumi: A table has just been created, modified or deleted.  

-- Nüüd vaatame nõidet, kuidas ära hoida kasutajatel loomaks, muutmaks või kustatamiseks tabelit. 
ALTER TRIGGER FirstTrigger 
ON Database
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK
PRINT 'You cannot create, modify, alter or drop a table'
END