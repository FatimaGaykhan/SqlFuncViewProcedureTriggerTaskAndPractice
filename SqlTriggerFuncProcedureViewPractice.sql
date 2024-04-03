-- use Course

-- SELECT * FROM Teachers

-- CREATE VIEW getTeachersWithId
-- AS
-- SELECT * FROM Teachers WHERE [Id]>3

-- SELECT * FROM getTeachersWithId

-- CREATE VIEW getTeachersWithAge
-- AS
-- SELECT TOP 3 * FROM Teachers WHERE[Age]>30

-- SELECT* FROM getTeachersWithAge

CREATE FUNCTION sayHelloWorld()
RETURNS nvarchar(50)
AS
BEGIN
RETURN 'Hello World'
END

-- SELECT  dbo.sayHelloWorld() as 'Data'

DECLARE @data NVARCHAR(50) =(SELECT  dbo.sayHelloWorld())
PRINT @data

CREATE FUNCTION dbo.ShowText(@text NVARCHAR(50))
RETURNS NVARCHAR(50)
AS
BEGIN
RETURN @text
END


SELECT dbo.ShowText('Hello Fatima')

CREATE FUNCTION dbo.SumOfNums(@num1 int,@num2 int )
RETURNS INT
AS
BEGIN
RETURN @num1+@num2
END

DECLARE @id int=(SELECT dbo.SumOfNums(3,4))
SELECT * FROM Employees WHERE[Id]=@id

SELECT * From employees

CREATE FUNCTION getTeachersCountByAge(@age int)
RETURNS INT
AS
BEGIN
DECLARE @count int
SELECT @count= Count(*) FROM Teachers WHERE[Age]>@age
return @count
END

SELECT dbo.getTeachersCountByAge(30) as 'Count'

CREATE FUNCTION dbo.GetAllTeachers()
RETURNS TABLE
AS
RETURN (SELECT * FROM Teachers)

SELECT * FROM dbo.GetAllTeachers()

CREATE FUNCTION dbo.searchTeachersByName(@searchText nvarchar(50))
RETURNS TABLE
AS
return(
    SELECT * FROM Teachers WHERE[Name] LIKE '%'+@searchText+'%'
)

SELECT * FROM dbo.searchTeachersByName('g')

SELECT * FROM Teachers

CREATE PROCEDURE usp_ShowText
AS
BEGIN
PRINT 'Salamlar'
END

usp_ShowText

CREATE PROCEDURE usp_ShowText2
@text NVARCHAR(50)
AS
BEGIN
PRINT @text
END

exec usp_ShowText2 'Salam Fatya'


CREATE PROCEDURE usp_createTeacher
@name nvarchar(50),
@surname nvarchar(50),
@email nvarchar(50),
@age int
AS
BEGIN
INSERT INTO Teachers ([Name],[Surname],[Email],[Age])
VALUES(@name,@surname,@email,@age)
END

EXEC usp_createTeacher 'Fexriyye','Tagizade','fexriyye@gmail.com',21

select * FROM Teachers ORDER BY [Age] DESC

CREATE PROCEDURE usp_deleteTeacherById
@id INT
AS
BEGIN
DELETE FROM Teachers Where [Id]=@id
END

EXEC usp_deleteTeacherById 4

CREATE FUNCTION dbo.getTeachersAgeAvg(@id int)
RETURNS INT
AS
BEGIN
Declare @ageAvg INT
SELECT @ageAvg = AVG(Age) FROM Teachers Where [Id]>@id
RETURN @ageAvg
END

SELECT dbo.getTeachersAgeAvg(3)



CREATE PROCEDURE usp_changeTeacherNameByCondition
@id int,
@name NVARCHAR(50)
AS
BEGIN
DECLARE @ageAvg int = (SELECT dbo.getTeachersAgeAvg(@id))
Update Teachers
SET [Name]=@name
WHERE [Age]>@ageAvg
END

EXEC usp_changeTeacherNameByCondition 3,'XXX'

CREATE TABLE TeacherLogs(
    [Id] INT PRIMARY KEY IDENTITY(1,1),
    [TeacherId] INT,
    [Operation] NVARCHAR(50),
    [Date] DATETIME
)

CREATE TRIGGER trg_createTeacherLogs on Teachers
AFTER INSERT
AS
BEGIN
insert into TeacherLogs([TeacherId],[Operation],[Date])
SELECT [Id],'Insert',GETDATE() from inserted
END

CREATE TRIGGER trg_deleteTeacherLogs on Teachers
AFTER Delete
AS
BEGIN
insert into TeacherLogs([TeacherId],[Operation],[Date])
SELECT [Id],'Delete',GETDATE() from deleted
END

CREATE TRIGGER trg_deleteTeacherLogs on Teachers
AFTER UPDATE
AS
BEGIN
insert into TeacherLogs([TeacherId],[Operation],[Date])
SELECT [Id],'Update',GETDATE() from deleted
END

select * from TeacherLogs

EXEC usp_createTeacher 'Afide','Valiyeva','afide@gmail.com',39

EXEC usp_deleteTeacherById 2

select * from teachers