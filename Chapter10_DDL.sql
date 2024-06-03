---Chapter 10 - DDL - Data Definition Language

---CREATE , ALTER , DROP

USE master;

GO

IF exists (select * from sysdatabases WHERE name = 'TestDB')
	DROP database TestDB;
go

CREATE DATABASE TestDB;

GO

USE TESTDB;

GO

CREATE TABLE tbl
(id INT);

GO

SELECT * FROM tbl;

go 

USE master;

GO

DROP DATABASE TestDB;


GO

CREATE DATABASE TestDB;


GO

USE TESTDB;

GO


CREATE TABLE tbl
(id INT,
 Lname VARCHAR(10),
 Fname VARCHAR,
 BirthDate DATE,
 Salary MONEY
 )

 --String or binary data would be truncated in table 'TestDB.dbo.tbl', column 'Fname'. Truncated value: 'M'.

 INSERT INTO tbl
 VALUES (1,'Cohen','Moshe','1996-01-01',5500)

GO
  INSERT INTO tbl
 VALUES (1,'Cohen','M','1996-01-01',5500)

GO
 SELECT * FROM tbl;

 GO
  INSERT INTO tbl
 VALUES (1,'Cohen','M','1996-01-01',5500);


 GO

 DROP TABLE tbl;


 GO
 ---CRETAE TABLE WITH CONSTRAINTS
 --NOT NULL  --NN
 --UNIQUE -- UK
 --CHECK -- CK
 --PRIMARY KEY --PK
 --FOREIGN KEY---FK


 ---NOT NULL

 CREATE TABLE tbl
(id INT NOT NULL,
 Lname VARCHAR(10) NOT NULL,
 Fname VARCHAR(10),
 BirthDate DATE,
 Salary MONEY
 );


 
 INSERT INTO tbl
 VALUES (1,'Cohen','Moshe','1996-01-01',5500)

 GO
 SELECT * FROM tbl;

 GO
 --Cannot insert the value NULL into column 'id', table 'TestDB.dbo.tbl'; column does not allow nulls. INSERT fails.
  INSERT INTO tbl
 VALUES (NULL,'Cohen','Moshe','1996-01-01',5500)


  INSERT INTO tbl
 VALUES (2,'Cohen',NULL,NULL,NULL)


  INSERT INTO tbl
 VALUES (2,'Cohen',NULL,NULL,NULL)
  GO
 SELECT * FROM tbl;

 
 GO
 INSERT INTO tbl
 VALUES (2,'Cohen',NULL,NULL,NULL);


  

 INSERT INTO tbl
 VALUES (3,'Levi','','','');


 
  GO
 SELECT * FROM tbl;

 GO


 INSERT INTO tbl
 VALUES (4,'BBB','Moshe',GETDATE(),-5500);


 GO

 DROP TABLE tbl;

 go


 
 ---UNIQUE

 CREATE TABLE tbl
(id INT UNIQUE,
 Lname VARCHAR(10) NOT NULL,
 Fname VARCHAR(10),
 Email VARCHAR(50) UNIQUE,
 Salary MONEY
 );

 GO

  INSERT INTO tbl
 VALUES (1,'Cohen','Moshe','moshe@gmail.com',5500)


 --Violation of UNIQUE KEY constraint 'UQ__tbl__A9D105347B9AE416'.
  INSERT INTO tbl
 VALUES (2,'Levi','Moshe','moshe@gmail.com',5500)


   INSERT INTO tbl
 VALUES (1,'Levi','Moshe','moshe@gmail.com',5500)

 GO
 drop table tbl;

 GO
 
 CREATE TABLE tbl
(id INT CONSTRAINT tbl_id_uk UNIQUE,
 Lname VARCHAR(10) NOT NULL,
 Fname VARCHAR(10),
 Email VARCHAR(50) CONSTRAINT tbl_email_uk UNIQUE,
 Salary MONEY
 );

 GO

  INSERT INTO tbl
 VALUES (2,'Levi','Moshe','moshe@gmail.com',5500)


 --Violation of UNIQUE KEY constraint 'tbl_email_uk'. Cannot insert duplicate key in object 'dbo.tbl'. The duplicate key value is (moshe@gmail.com).

   INSERT INTO tbl
 VALUES (1,'Levi','Moshe','moshe@gmail.com',5500)

select * from tbl;


--Violation of UNIQUE KEY constraint 'tbl_email_uk'. Cannot insert duplicate key in object 'dbo.tbl'. The duplicate key value is (moshe@gmail.com).

    INSERT INTO tbl
 VALUES (2,'Cohen','Moshe','moshe@gmail.com',5500)

 --Violation of UNIQUE KEY constraint 'tbl_id_uk'. Cannot insert duplicate key in object 'dbo.tbl'. The duplicate key value is (2).

     INSERT INTO tbl
 VALUES (2,'Cohen','Moshe','moshe1@gmail.com',5500)


      INSERT INTO tbl
 VALUES (null,'Cohen','Moshe','moshe1@gmail.com',5500)

--Violation of UNIQUE KEY constraint 'tbl_id_uk'. Cannot insert duplicate key in object 'dbo.tbl'. The duplicate key value is (<NULL>).

       INSERT INTO tbl
 VALUES (null,'Cohen','Moshe','mm@gmail.com',5500)



        INSERT INTO tbl
 VALUES (3,'Cohen','Moshe',null,5500)


--- Violation of UNIQUE KEY constraint 'tbl_email_uk'. Cannot insert duplicate key in object 'dbo.tbl'. The duplicate key value is (<NULL>).

        INSERT INTO tbl
 VALUES (4,'Cohen','Moshe',null,5500)


 GO

 GO
 drop table tbl;

 GO
 
 CREATE TABLE tbl
(id INT CONSTRAINT tbl_id_pk PRIMARY KEY,
 Lname VARCHAR(10) NOT NULL,
 Fname VARCHAR(10),
 Email VARCHAR(50) CONSTRAINT tbl_email_uk UNIQUE,
 Salary MONEY
 );

 ---Cannot insert the value NULL into column 'id'
       INSERT INTO tbl
 VALUES (null,'Cohen','Moshe','moshe@gmail.com',5500)


        INSERT INTO tbl
 VALUES (1,'Cohen','Moshe','moshe@gmail.com',5500)


--Violation of PRIMARY KEY constraint 'tbl_id_pk'. Cannot insert duplicate key in object 'dbo.tbl'. The duplicate key value is (1).

         INSERT INTO tbl
 VALUES (1,'BBB','Moshe','moshe1@gmail.com',5500)



          INSERT INTO tbl
 VALUES (2,'BBB','Moshe',NULL,5500)

--Violation of UNIQUE KEY constraint 'tbl_email_uk'. Cannot insert duplicate key in object 'dbo.tbl'. The duplicate key value is (<NULL>).

           INSERT INTO tbl
 VALUES (3,'BBB','Moshe',NULL,5500)


            INSERT INTO tbl
 VALUES (4,'BBB','Moshe','M',-5500);


 SELECT * FROM tbl


 ---CHECK CONSTRAINT

 
 GO
 drop table tbl;

 GO
 
 CREATE TABLE tbl
(id INT CONSTRAINT tbl_id_pk PRIMARY KEY,
 Lname VARCHAR(10) NOT NULL,
 Fname VARCHAR(10),
 Email VARCHAR(50) CONSTRAINT tbl_email_ck check(email LIKE '%@%' AND (email LIKE '%.IL' OR email LIKE '%.COM')),
 Salary MONEY CONSTRAINT tbl_sal_ck CHECK(salary >=6000)
 );


 INSERT INTO tbl
 VALUES (1,'BBB','Moshe','M@gmail.com',15500);


 SELECT * FROM tbl;

 SP_HELP tbl--ALT+F1

  INSERT INTO tbl
 VALUES (2,'BBB','Moshe','M@gmail.com',15500);


 --The INSERT statement conflicted with the CHECK constraint "tbl_email_ck". The conflict occurred in database "TestDB", table "dbo.tbl", column 'Email'.

  INSERT INTO tbl
 VALUES (3,'BBB','Moshe','Mgmail.com',15500);

---The INSERT statement conflicted with the CHECK constraint "tbl_sal_ck". The conflict occurred in database "TestDB", table "dbo.tbl", column 'Salary'.
   INSERT INTO tbl
 VALUES (3,'BBB','Moshe','Moshe@gmail.com',5999.99);



 ---FOREIGN KEY CONSTRAINT


 DROP TABLE tbl;

 GO

 CREATE TABLE Dep
 (DepID INT CONSTRAINT dep_id_pk PRIMARY KEY,
  DepName VARCHAR(20) NOT NULL
  );

  GO

CREATE TABLE Emp
(EmpID INT CONSTRAINT emp_id_pk PRIMARY KEY,
 LastName VARCHAR(25) NOT NULL,
 FirstName VARCHAR(20) ,
 Email VARCHAR(50) CONSTRAINT EMP_email_uk UNIQUE,
 Salary MONEY CONSTRAINT emp_sal_ck check(salary >=6000),
 Dep_id INT CONSTRAINT emp_depid_fk FOREIGN KEY REFERENCES dep(depid)
);

SP_HELP emp


go

INSERT INTO dep
VALUES (10,'IT')


GO

SELECT * FROM dep;


GO

INSERT INTO emp
VALUES (1,'Moshe','Moshe','moshe@gmail.com',7000,10);

go
SELECT * FROM dep;
SELECT * FROM emp;


INSERT INTO emp
VALUES (2,'David','David','davi@gmail.com',27000,10);




INSERT INTO emp
VALUES (3,'Nina','Nina','nina@gmail.com',37000,NULL);



--The INSERT statement conflicted with the FOREIGN KEY constraint "emp_depid_fk". The conflict occurred in database "TestDB", table "dbo.Dep", column 'DepID'.

INSERT INTO emp
VALUES (4,'Pnina','Pnina','pnina@gmail.com',8000,20);


go

INSERT INTO dep
VALUES (20,'HR')

GO

INSERT INTO emp
VALUES (4,'Pnina','Pnina','pnina@gmail.com',8000,20);


---IDENTITY

DROP TABLE EMP;


 GO

CREATE TABLE Emp
(EmpID INT IDENTITY CONSTRAINT emp_id_pk PRIMARY KEY,
 LastName VARCHAR(25) NOT NULL,
 FirstName VARCHAR(20) ,
 Email VARCHAR(50) CONSTRAINT EMP_email_uk UNIQUE,
 Salary MONEY CONSTRAINT emp_sal_ck check(salary >=6000),
 Dep_id INT CONSTRAINT emp_depid_fk FOREIGN KEY REFERENCES dep(depid)
);


GO
--An explicit value for the identity column in table 'emp' can only be specified when a column list is used and IDENTITY_INSERT is ON.
INSERT INTO emp
VALUES (1,'Moshe','Moshe','moshe@gmail.com',7000,10);



INSERT INTO emp
VALUES ('Moshe','Moshe','moshe@gmail.com',7000,10);


SELECT * FROM dep;
SELECT * FROM emp;


INSERT INTO emp
VALUES ('David','David','davi@gmail.com',27000,10);


SELECT @@IDENTITY


GO



DROP TABLE EMP;


 GO

CREATE TABLE Emp
(EmpID INT IDENTITY(1000,1) CONSTRAINT emp_id_pk PRIMARY KEY,
 LastName VARCHAR(25) NOT NULL,
 FirstName VARCHAR(20) ,
 Email VARCHAR(50) CONSTRAINT EMP_email_uk UNIQUE,
 Salary MONEY CONSTRAINT emp_sal_ck check(salary >=6000),
 Dep_id INT CONSTRAINT emp_depid_fk FOREIGN KEY REFERENCES dep(depid)
);


GO


INSERT INTO emp
VALUES ('Moshe','Moshe','moshe@gmail.com',7000,10);


SELECT * FROM dep;
SELECT * FROM emp;


INSERT INTO emp
VALUES ('David','David','davi@gmail.com',27000,10);

--The INSERT statement conflicted with the FOREIGN KEY constraint "emp_depid_fk". The conflict occurred in database "TestDB", table "dbo.Dep", column 'DepID'.
INSERT INTO emp
VALUES ('David','David','davi1@gmail.com',27000,100);



INSERT INTO emp
VALUES ('David','David','davi1@gmail.com',27000,10);





---


DROP TABLE EMP;


 GO

CREATE TABLE Emp
(EmpID INT IDENTITY CONSTRAINT emp_id_pk PRIMARY KEY,
 LastName VARCHAR(25) NOT NULL,
 FirstName VARCHAR(20) ,
 Email VARCHAR(50) CONSTRAINT EMP_email_uk UNIQUE,---coumn level constraint
 Salary MONEY CONSTRAINT emp_sal_ck check(salary >=6000),
 Dep_id INT CONSTRAINT emp_depid_fk FOREIGN KEY REFERENCES dep(depid),
 --Table level constraint
 CONSTRAINT emp_email_ck CHECK(email LIKE '%@%')
);


SP_HELP EMP


GO
DROP TABLE EMP;


 GO

CREATE TABLE Emp
(EmpID INT IDENTITY CONSTRAINT emp_id_pk PRIMARY KEY,
 LastName VARCHAR(25) NOT NULL,
 FirstName VARCHAR(20) ,
 Email VARCHAR(50) CONSTRAINT emp_email_ck CHECK(email LIKE '%@%'),---coumn level constraint
 Salary MONEY CONSTRAINT emp_sal_ck check(salary >=6000),
 Dep_id INT CONSTRAINT emp_depid_fk FOREIGN KEY REFERENCES dep(depid),
 --Table level constraint
 CONSTRAINT EMP_email_uk UNIQUE(EMAIL)
);


GO

DROP TABLE Dep;
DROP TABLE Emp;

 GO

 CREATE TABLE Dep
 (DepID INT CONSTRAINT dep_id_pk PRIMARY KEY,---Co;umn level constraint
  DepName VARCHAR(20) NOT NULL
  );

  GO

CREATE TABLE Emp
(EmpID INT IDENTITY,
 LastName VARCHAR(25) NOT NULL,---only column level
 FirstName VARCHAR(20) ,
 Email VARCHAR(50),
 Salary MONEY ,
 Dep_id INT ,
 --Table level constraint
 CONSTRAINT emp_id_pk PRIMARY KEY(empid),
 CONSTRAINT emp_name_uk UNIQUE(LastName),
 CONSTRAINT emp_email_uk UNIQUE(Email),
 CONSTRAINT emp_email_ck CHECK(email LIKE '%@%'),
 CONSTRAINT emp_sal_ck check(salary >=6000),
 CONSTRAINT emp_depid_fk FOREIGN KEY(dep_id) REFERENCES dep(depid)

);



SP_HELP emp


GO

USE MASTER

GO

CREATE DATABASE BankDB;

GO
USE BANKDB


GO

CREATE TABLE BANK
(BankID INT  CONSTRAINT BANK_ID_PK PRIMARY KEY,
 BankName VARCHAR (15) NOT NULL,
 City VARCHAR (20) ,
 Address VARCHAR (30),
);
GO

CREATE TABLE SNIFIM
(Snifid INT  ,
SnifName VARCHAR (20) NOT NULL,
Address VARCHAR (30) ,
City VARCHAR (20),
BankId INT ,
CONSTRAINT Snif_ID_PK PRIMARY KEY(Snifid),
CONSTRAINT Bank_id_fk FOREIGN KEY (BankId) REFERENCES BANK (BankID)
)


SELECT * FROM bank;
SELECT * FROM snifim;


INSERT INTO bank
VALUES (10,'Leumi','Tel Aviv',NULL)


INSERT INTO snifim
VALUES (555,'Avivim',NULL,NULL,10)



INSERT INTO snifim
VALUES (556,'Revivim',NULL,NULL,10)

go
use TestDB
go


SELECT * FROM DEP
SELECT * FROM emp



go

INSERT INTO dep
VALUES (10,'IT'),
		(20,'HR'),
		(30,'QA')



INSERT INTO emp
VALUES ('David','David','davi1@gmail.com',27000,10),
		('Moshe','Moshe','moshe@gmail.com',9000,10);


--Violation of UNIQUE KEY constraint 'emp_email_uk'. Cannot insert duplicate key in object 'dbo.Emp'. The duplicate key value is (aviv@gmail.com).

INSERT INTO emp
VALUES ('Noam','Noam','noam@gmail.com',27000,20),
		('Aviv','Aviv','aviv@gmail.com',19000,10),
		('Aviva','Aviva','aviv@gmail.com',19000,10);


SELECT * FROM emp;

INSERT INTO emp
VALUES ('Noam','Noam','noam@gmail.com',27000,20),
		('Aviv','Aviv','aviv@gmail.com',19000,10)

---ALTER TABLE
--ADD|DROP|ALTER

ALTER TABLE emp
ADD Pohne VARCHAR(10) 

INSERT INTO emp
VALUES ('NamA','NamA','namA@gmail.com',17000,20,'03-5555555')

--String or binary data would be truncated in table 'TestDB.dbo.Emp', column 'Pohne'. Truncated value: '053-555555'.

INSERT INTO emp
VALUES ('BB','BB','bb@gmail.com',17000,20,'053-555555555')



ALTER TABLE emp
ALTER COLUMN Pohne VARCHAR(15) 



INSERT INTO emp
VALUES ('BB','BB','bb@gmail.com',17000,20,'053-555555555')



SELECT *,LEN(Pohne) FROM emp;


--String or binary data would be truncated in table 'TestDB.dbo.Emp', column 'Pohne'. Truncated value: ''.
ALTER TABLE emp
ALTER COLUMN Pohne VARCHAR(11) 



ALTER TABLE emp
ALTER COLUMN Pohne VARCHAR(13) 


ALTER TABLE emp
DROP COLUMN Pohne



SELECT *FROM emp;


--ALTER TABLE only allows columns to be added that can contain nulls, or have a DEFAULT definition specified, or the column being added is an identity or timestamp column, or alternatively if none of the previous conditions are satisfied the table must be empty to allow addition of this column. Column 'Phone' cannot be added to non-empty table 'emp' because it does not satisfy these conditions.

ALTER TABLE emp
ADD Phone VARCHAR(10) NOT NULL


ALTER TABLE emp
ADD Phone VARCHAR(10) DEFAULT '03' NOT NULL



ALTER TABLE emp
ADD fAX VARCHAR(10) DEFAULT '03' 



INSERT INTO emp
VALUES ('BB','BB','bbB@gmail.com',17000,20,DEFAULT,DEFAULT)


INSERT INTO emp
VALUES ('CC','CC','CC@gmail.com',DEFAULT,DEFAULT,DEFAULT,NULL)


ALTER TABLE emp
DROP CONSTRAINT emp_sal_ck;


INSERT INTO emp
VALUES ('CCC','CCC','CCC@gmail.com',0,DEFAULT,DEFAULT,NULL)


--The ALTER TABLE statement conflicted with the CHECK constraint "emp_sal_ck". The conflict occurred in database "TestDB", table "dbo.Emp", column 'Salary'.

ALTER TABLE emp
ADD CONSTRAINT emp_sal_ck CHECK (salary >=6000);





ALTER TABLE emp
ADD CONSTRAINT emp_sal_ck CHECK (salary >=0);


----Complex Constraints

CREATE TABLE video
(v_id INT,
 v_copy INT,
 v_name VARCHAR(100),
 CONSTRAINT video_id_copy_pk PRIMARY KEY(v_id,v_copy)
 )

 INSERT INTO video
 VALUES (1,1,'A'),
		(1,2,'A'),
		(1,3,'A'),
		(2,1,'B'),
		(2,2,'B'),
		(2,3,'B')

		SELECT * FROM video



--Violation of PRIMARY KEY constraint 'video_id_copy_pk'. Cannot insert duplicate key in object 'dbo.video'. The duplicate key value is (1, 1).
 INSERT INTO video
 VALUES (1,1,'A')


 ---COPY TABLE 


 SELECT *
 INTO new_emp
 FROM emp;


  SELECT *
 FROM new_emp



 SELECT EmpID , LastName ,Salary
 INTO new_emp1
 FROM emp;



   SELECT *
 FROM new_emp1


 SELECT *
 INTO pro
 FROM Northwind.dbo.Products;


 select *
 from pro


  SELECT ProductID , ProductName , CategoryID , UnitPrice
 INTO pro1
 FROM Northwind.dbo.Products;


   SELECT ProductID , ProductName , CategoryID catid , UnitPrice AS proce
 INTO pro2
 FROM Northwind.dbo.Products;


 SELECT * FROM pro2;



 SELECT ProductID , ProductName , CategoryID catid , UnitPrice AS price
 INTO pro3
 FROM Northwind.dbo.Products
 WHERE CategoryID =1;



  SELECT * FROM pro3;


 SELECT *
 INTO pro4
 FROM Northwind.dbo.Products
 WHERE 1=2;


   SELECT * FROM pro4;



