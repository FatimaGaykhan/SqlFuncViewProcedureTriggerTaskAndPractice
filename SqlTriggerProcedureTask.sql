CREATE DATABASE CourseDB
USE CourseDB

CREATE TABLE Students(
    [Id] INT PRIMARY KEY IDENTITY(1,1),
    [Name] NVARCHAR(50),
    [Surname] NVARCHAR(50),
    [Age] INT,
    [Email] NVARCHAR(50),
    [Address] NVARCHAR(50)
)

INSERT INTO Students ([Name],[Surname],[Age],[Email],[Address])
VALUES
('Inji','Qayxanova',27,'inji@gmail.com','Xetai'),
('Samir','Eliyev',45,'samir@gmail.com','Kurdexani'),
('Ilgar','Shiriyev',27,'ilgar@gmail.com','Yasamal')


SELECT * FROM Students

CREATE PROCEDURE usp_deleteStudentById
@id INT
AS
BEGIN
DELETE FROM Students WHERE[Id]=@id
END

EXEC usp_deleteStudentById 3

CREATE TABLE StudentArchives(
    [Id] INT PRIMARY KEY IDENTITY(1,1),
    [StudentId] INT,
    [Operation] NVARCHAR(50),
    [Date] DATETIME
)

CREATE TRIGGER trg_deleteStudentArchives on Students
AFTER DELETE
AS
BEGIN
INSERT INTO StudentArchives([StudentId],[Operation],[Date])
SELECT [Id],'Delete',GETDATE() FROM deleted
END

SELECT * FROM StudentArchives



