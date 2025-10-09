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

-- Kui lubada triggerit
DISABLE TRIGGER FirstTrigger ON DATABASE
-- Kuidas kustutada triggerit
DROP TRIGGER FirstTrigger ON DATABASE

-- Järgnev trigger käivitub, kui peaksid kasutama sp_rename käsklust süsteemi stored procedurite muutmisel.
CREATE TRIGGER RenameTable 
ON Database
FOR RENAME
AS
BEGIN
ROLLBACK
PRINT 'You just renamed something'
END

-- JÄrgnev kood muudab TestTable nime NewTestTable nimeks
sp_rename 'TestTable', 'NewTestTable' 
-- JÄrgnev kood muudab Id veergu NewTestTabel tabelis NewId peale
sp_rename 'NewTestTable.Id' , 'NewId', 'column'



-- Server-Scoped DDL triggerid
-- Käsitletav trigger on andmebaasi vahemikus olev trigger. See ei luba luua, muuta ja kustutada tabeleid andmebaasist sinna, kuhu see on loodud
CREATE TRIGGER tr_DatabaseScopeTrigger 
ON Database
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK
PRINT 'You cannot create, modify, alter or drop a table in the current database'
END

-- Loo Serveri-vahemikus olev DDL trigger: See on nagu andembaasi vahemiku trigger, aga erinevus seisneb, et sa pead lisama koodis sõna ALL peale
CREATE TRIGGER tr_ServerScopeTrigger
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK
PRINT 'You cannot create, modify, alter or drop a table in the current database'
END