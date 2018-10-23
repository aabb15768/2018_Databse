/* create and use database */
CREATE DATABASE SecondHandBookstore;
USE SecondHandBookstore;

/* info */
CREATE TABLE Self (
    StuID varchar(10) NOT NULL,
    Department varchar(10) NOT NULL,
    SchoolYear int DEFAULT 1,
    StuName varchar(10) NOT NULL,
    PRIMARY KEY (StuID)
);

INSERT INTO Self
VALUES ('B03204032', '地質系', 3, '李彥均');

SELECT DATABASE();
SELECT * FROM Self;

/* create table */
CREATE TABLE Members (
    MemberID varchar(8) NOT NULL,
    MemberName varchar(40) NOT NULL,
    AccountBalance int(7) DEFAULT 0 CHECK (AccountBalance >= 0),
    Address varchar(100) NOT NULL,
    MemberLadder ENUM('Normal','Silver','Gold'),
    PRIMARY KEY (MemberID)
);

CREATE TABLE Bookcases (
	BookcaseID int(3) NOT NULL CHECK (BookcaseID >= 0),
    Attribute varchar(50) ,
    BookNumber int(3) DEFAULT 0 CHECK(BookNumber >= 0),
    BookcaseSize ENUM ('Small','Medium', 'Large'),
    PRIMARY KEY(BookcaseID)
);

CREATE TABLE Books (
	BookName varchar(50) NOT NULL,
    BookPrice int(5) DEFAULT 0 CHECK (BookPrice >= 0),
    OnShelfDate DATE NOT NULL,
    MemberID varchar(8) NOT NULL,
    BookcaseID int(3) ,
    PRIMARY KEY(MemberID, BookName),
	FOREIGN KEY(MemberID)
		REFERENCES Members (MemberID)
        ON DELETE CASCADE,
	FOREIGN KEY(BookcaseID)
		REFERENCES Bookcases (BookcaseID)
        ON DELETE SET NULL
);

CREATE TABLE Employees(
	EmployeeName varchar(40) NOT NULL,
    EmployeeSalary int(6) DEFAULT 22000,
    DayWorkHours int(2) NOT NULL CHECK (DayWorkHours >= 0 AND DayWorkHours <= 12),
    PRIMARY KEY(EmployeeName)
);

CREATE TABLE DeliveryCompany (
	CompanyName varchar(40) NOT NULL,
    PhoneNumber varchar(20) NOT NULL,
    DeliveryCost int(4) DEFAULT 0 CHECK (DeliveryCost >= 0),
    CompanyLevel ENUM('Cheap', 'Normal', 'Expensive'),
    PRIMARY KEY (CompanyName)
);

CREATE TABLE BookOrders (
	OrderID int(6) NOT NULL,
    Bookname varchar(50) NOT NULL,
    MemberID varchar(8) NOT NULL,
    CompanyName varchar(40) NOT NULL,
    ProcessedEmployee varchar(40) DEFAULT 'Steven',
	PRIMARY KEY (OrderID),
    FOREIGN KEY(MemberID)
		REFERENCES Members(MemberID),
	FOREIGN KEY(CompanyName)
		REFERENCES DeliveryCompany(CompanyName)
);
/*can not have default value*/
CREATE TABLE EvaluateRecord (
	EvaluatingID varchar(8) NOT NULL,
    EvaluatedID varchar(8) NOT NULL,
    RecordID int (6) NOT NULL,
    PRIMARY KEY (RecordID),
    FOREIGN KEY(EvaluatingID)
		REFERENCES Members(MemberID),
	FOREIGN KEY(EvaluatedID)
		REFERENCES Members(MemberID)
);
 
 CREATE TABLE RemitRecord (
	RecordID int(6) NOT NULL,
	ProcessedEmployee varchar(40) NOT NULL,
    MoneyRemitted int(7) DEFAULT 0,
    RemittedMember varchar(8) NOT NULL,
	PRIMARY KEY (RecordID),
    FOREIGN KEY(ProcessedEmployee)
		REFERENCES Employees(EmployeeName),
	FOREIGN KEY(RemittedMember)
		REFERENCES Members(MemberID)
 );


/* insert */
INSERT INTO Members
VALUES 
('00000001', 'Snoopy', 0, '新北市新莊區', 'Normal'),
('00000002', 'Steven', 0, '台北市大同區', 'Silver'),
('00000003', 'Lee', 0, '台北市士林區', 'Gold');

INSERT INTO Bookcases
VALUES 
(1, 'Novel', 0, 'Small'),
(2, 'Textbook', 0, 'Medium'),
(3, 'Verse', 0, 'Large');

INSERT INTO Books
VALUES 
('Fire Forest', 1000, '2018-09-24', '00000001', 1),
('Cold Winter', 250, '2018-09-25', '00000002', 2),
('Nice Girl', 500, '2018-09-26', '00000003', 3);

INSERT INTO Employees
VALUES 
('Leo', 30000, 10),
('Bob', 30000, 10),
('Alice', 30000, 10);

INSERT INTO DeliveryCompany
VALUES 
('Cheap Company', '0900123456', 20, 'Cheap'),
('Normal Company', '0988123456', 50, 'Normal'),
('Expensive Company', '0977123456', 10, 'Expensive');

INSERT INTO BookOrders
VALUES 
(1, 'Fire Forest', '00000001', 'Cheap Company', 'Leo'),
(2, 'Cold Winter', '00000002', 'Normal Company', 'Bob'),
(3, 'Nice Girl', '00000003', 'Expensive Company', 'Alice');

INSERT INTO EvaluateRecord
VALUES 
('00000001', '00000002', 1),
('00000002', '00000003', 2),
('00000003', '00000001', 3);

INSERT INTO RemitRecord
VALUES 
(1, 'Leo', 1000, '00000001'),
(2, 'Bob', 2000, '00000002'),
(3, 'Alice', 3000, '00000003');

/* select from all tables */
SELECT * FROM Members;
SELECT * FROM Books;
SELECT * FROM Bookcases;
SELECT * FROM Employees;
SELECT * FROM DeliveryCompany;
SELECT * FROM BookOrders;
SELECT * FROM EvaluateRecord;
SELECT * FROM RemitRecord;



/* drop database */
DROP DATABASE SecondHandBookstore;
