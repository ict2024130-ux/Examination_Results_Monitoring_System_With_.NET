DROP DATABASE ERMS;

CREATE DATABASE IF NOT EXISTS ERMS
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ERMS;
/*CHARACTER SET utf8mb4;*/
/*Creating Employee Table store Emplyee Details (Employee_ID, First_Name, Last_Name, Adress_Line_1, Adress_Line_2, Email, Contact_Number)*/
CREATE TABLE Employee(
    Employee_ID INT AUTO_INCREMENT PRIMARY KEY , /* first employee ID:  00001 */
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Adress_Line_1 VARCHAR(50) NOT NULL,
    Adress_Line_2 VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Contact_Number VARCHAR(10) NOT NULL
)Engine = innodb;

/*Creating Employee Qualification Table to store Employee Qualifications(Employee_ID, Qualification)*/
CREATE TABLE Employee_Qualification(
    Employee_ID INT NOT NULL,
    Qualification VARCHAR(50) NOT NULL,
    PRIMARY KEY (Employee_ID, Qualification),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
    ON DELETE cascade
)Engine = innodb;

/*Create table Semester to store Semester Details (`Year`, Semester_ID, Start_Date, Due_Date)*/
CREATE TABLE Semester(
    `Year` INT NOT NULL,
    Semester_ID INT NOT NULL,
    Start_Date DATE NOT NULL,
    Due_Date DATE NOT NULL,
    PRIMARY KEY (`Year`, Semester_ID)
)Engine = innodb;

/*Create Table Course to store Course Details (Course_Code, Name, Description )*/
CREATE TABLE Course(
    Course_Code VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(100) NOT NULL
)Engine = innodb;

/*Create Exam Packet Table to store Exam Packet Tracking Details(`Year`, Semester_ID, Course_Code, Packet_Submission_Date, EIS_Update_Date, Handover_Date, Packet_Count, Document_URL)*/
CREATE TABLE Exam_Packet_Tracking(
    `Year` INT NOT NULL,
    Semester_ID INT NOT NULL,
    Course_Code VARCHAR(10) NOT NULL,
    Packet_Submission_Date DATE,
    EIS_Update_Date DATE,
    Handover_Date DATE,
    Packet_Count INT,
    Document_URL VARCHAR(100),
    PRIMARY KEY (`Year`, Semester_ID, Course_Code),
    FOREIGN KEY (`Year`, Semester_ID) REFERENCES Semester(`Year`, Semester_ID) ON DELETE RESTRICT,
    FOREIGN KEY (Course_Code) REFERENCES Course(Course_Code) ON DELETE RESTRICT
)Engine = innodb;

/*Create Exam Offering Table to store Subject Details (`Year`, Semester_ID, Course_Code, Exam_Date, Answer_Script_Count, Status)*/
CREATE TABLE Exam_Offering(
    `Year` INT NOT NULL,
    Semester_ID INT NOT NULL,
    Course_Code VARCHAR(10) NOT NULL,
    Exam_Date DATE NOT NULL,
    Answer_Script_Count INT NOT NULL,
    `Status` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`Year`, Semester_ID, Course_Code),
    FOREIGN KEY (`Year`, Semester_ID) REFERENCES Semester(`Year`, Semester_ID) ON DELETE RESTRICT,
    FOREIGN KEY (Course_Code) REFERENCES Course(Course_Code) ON DELETE RESTRICT
)Engine = innodb;

/*Create Table Lecturer in Charge to store Lecturers (Employee_ID)*/
CREATE TABLE Lecturer_in_Charge(
    Employee_ID INT PRIMARY KEY,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE RESTRICT
)Engine = innodb;

/*Create Table Second Examiners to store Second Examiners (Employee_ID)*/
CREATE TABLE Second_Examiner(
    Employee_ID INT  PRIMARY KEY,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE RESTRICT
)Engine = innodb;

/*Create Table Moderators to store Moderators (Employee_ID)*/
CREATE TABLE Moderator(
    Employee_ID INT PRIMARY KEY,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE RESTRICT
)Engine = innodb;

/*Create Table Employee Type store Employee Types (`Type`, Description)*/
CREATE TABLE Employee_Type(
    `Type` VARCHAR(20) PRIMARY KEY,
    Description VARCHAR(100) NOT NULL
)Engine = innodb;

/*Create Table Admin to store System Admins (Employee_ID, `Type`)*/
CREATE TABLE `Admin`(
    Employee_ID INT PRIMARY KEY,
    `Type` VARCHAR(20) NOT NULL,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE RESTRICT,
    FOREIGN KEY (`Type`) REFERENCES Employee_Type(`Type`) ON DELETE RESTRICT
)Engine = innodb;

/*Create Table Admin_Course to store Admin Course Details (Employee_ID, `Year`, Semester_ID, Course_Code, Transaction_Type)*/
CREATE TABLE Admin_Course(
    Employee_ID INT  NOT NULL,
    `Year` INT NOT NULL,
    Semester_ID INT NOT NULL,
    Course_Code VARCHAR(10) NOT NULL,
    Transaction_Type VARCHAR(50) NOT NULL,
    PRIMARY KEY (Employee_ID, `Year`, Semester_ID, Course_Code),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE RESTRICT,
    FOREIGN KEY (`Year`, Semester_ID) REFERENCES Semester(`Year`, Semester_ID) ON DELETE RESTRICT,
    FOREIGN KEY (Course_Code) REFERENCES Course(Course_Code) ON DELETE RESTRICT
)Engine = innodb;

/*Create Table Hand Over to store Exam Packets' Handover Details (Employee_ID, Course_Code, `Date`)*/
CREATE TABLE Hand_Over(
    Employee_ID INT  NOT NULL,
    Course_Code VARCHAR(10) NOT NULL,
    `Date` DATE NOT NULL,
    PRIMARY KEY (Employee_ID, Course_Code),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE RESTRICT,
    FOREIGN KEY (Course_Code) REFERENCES Course(Course_Code) ON DELETE RESTRICT
)Engine = innodb;



/*Create Table Users to store login details (Employee_ID, Password)*/
CREATE TABLE Users(
    Employee_ID INT  PRIMARY KEY,
    `Password` VARCHAR(20) NOT NULL,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE RESTRICT
)Engine = innodb;

CREATE INDEX Search_Avaliable_Second_Eaxminers
ON Employee_Qualification(Qualification);
-- ==================== DATA INSERTS ====================

INSERT INTO Employee (Employee_ID, First_Name, Last_Name, Adress_Line_1, Adress_Line_2, Email, Contact_Number) 
VALUES 
('00001', 'Nimal', 'Perera', 'No 12', 'Colombo', 'nimal@uni.lk', '0711111111'),
('00002', 'Kamala', 'Silva', 'No 13', 'Kandy', 'kamala@uni.lk', '0712222222'),
('00003', 'Sunil', 'Fernando', 'No 14', 'Galle', 'sunil@uni.lk', '0713333333'),
('00004', 'Amara', 'Jayasinghe', 'No 15', 'Matara', 'amara@uni.lk', '0714444444'),
('00005', 'Ruwan', 'Kumara', 'No 16', 'Gampaha', 'ruwan@uni.lk', '0715555555'),
('00006', 'Chithra', 'Bandara', 'No 17', 'Kalutara', 'chithra@uni.lk', '0716666666'),
('00007', 'Anura', 'Ranasinghe', 'No 18', 'Negombo', 'anura@uni.lk', '0717777777'),
('00008', 'Geetha', 'Senaratne', 'No 19', 'Kurunegala', 'geetha@uni.lk', '0718888888'),
('00009', 'Mahesh', 'Gunawardena', 'No 20', 'Ratnapura', 'mahesh@uni.lk', '0719999999'),
('00010', 'Sarath', 'Dissanayake', 'No 21', 'Anuradhapura', 'sarath@uni.lk', '0721111111'),
('00011', 'Malini', 'Wickramasinghe', 'No 22', 'Badulla', 'malini@uni.lk', '0722222222'),
('00012', 'Nuwan', 'Herath', 'No 23', 'Jaffna', 'nuwan@uni.lk', '0723333333'),
('00013', 'Chandana', 'Rathnayake', 'No 24', 'Trincomalee', 'chandana@uni.lk', '0724444444'),
('00014', 'Pushpa', 'Jayawardena', 'No 25', 'Batticaloa', 'pushpa@uni.lk', '0725555555'),
('00015', 'Lalith', 'Peiris', 'No 26', 'Matale', 'lalith@uni.lk', '0726666666'),
('00016', 'Prof. Rohan', 'Abeysekera', 'No 27', 'Colombo', 'rohan@uni.lk', '0727777777'),
('00017', 'Prof. Priyani', 'Soysa', 'No 28', 'Kandy', 'priyani@uni.lk', '0728888888'),
('00018', 'Prof. Sunil', 'Wijesinghe', 'No 29', 'Galle', 'sunil.w@uni.lk', '0729999999');

INSERT INTO Employee_Qualification (Employee_ID, Qualification) 
VALUES 
('00001', 'Temporary Lecturer'), ('00002', 'Temporary Lecturer'), ('00003', 'Temporary Lecturer'),
('00004', 'Probationary Lecturer'), ('00005', 'Probationary Lecturer'), ('00006', 'Probationary Lecturer'),
('00007', 'Temporary Senior Lecturer'), ('00008', 'Temporary Senior Lecturer'), ('00009', 'Temporary Senior Lecturer'),
('00010', 'Senior Lecturer Grade 2'), ('00011', 'Senior Lecturer Grade 2'), ('00012', 'Senior Lecturer Grade 2'),
('00013', 'Senior Lecturer Grade 1'), ('00014', 'Senior Lecturer Grade 1'), ('00015', 'Senior Lecturer Grade 1'),
('00016', 'Professor'), ('00017', 'Professor'), ('00018', 'Professor');

INSERT INTO Lecturer_in_Charge (Employee_ID) VALUES ('00007'), ('00010'), ('00013'), ('00016');
INSERT INTO Second_Examiner (Employee_ID) VALUES ('00004'), ('00008'), ('00011'), ('00014');
INSERT INTO Moderator (Employee_ID) VALUES ('00005'), ('00009'), ('00012'), ('00017');

INSERT INTO Course (Course_Code, Name, Description) 
VALUES 
('ICT1101', 'Fundamentals of Computer Systems', 'Introduction to computer hardware, software, and basic architecture.'),
('ICT1202', 'Database Management Systems', 'Relational database design, SQL, and database administration.'),
('ICT1402', 'Principles Programming and Program Designing', 'Core programming concepts, logic formulation, and algorithm design.'),
('ICT2101', 'Object Oriented Programming', 'Advanced programming using Java and object-oriented principles.'),
('ICT2203', 'Web Technologies and Development', 'Front-end and back-end web development principles and frameworks.');

INSERT INTO Semester (`Year`, Semester_ID, Start_Date, Due_Date) 
VALUES 
(2026, 1, '2026-01-15', '2026-06-15'),
(2026, 2, '2026-07-01', '2026-12-01');

INSERT INTO Exam_Packet_Tracking (`Year`, Semester_ID, Course_Code, Packet_Submission_Date, EIS_Update_Date, Handover_Date, Packet_Count, Document_URL) 
VALUES 
(2026, 1, 'ICT1101', '2026-06-20', '2026-06-22', '2026-06-25', 120, 'http://docs.uni.lk/ict1101'),
(2026, 1, 'ICT1202', '2026-06-21', '2026-06-23', '2026-06-26', 140, 'http://docs.uni.lk/ict1202'),
(2026, 1, 'ICT1402', '2026-06-22', '2026-06-24', '2026-06-27', 165, 'http://docs.uni.lk/ict1402'),
(2026, 2, 'ICT2101', '2026-11-15', '2026-11-18', '2026-11-20', 110, 'http://docs.uni.lk/ict2101'),
(2026, 2, 'ICT2203', '2026-11-16', '2026-11-19', '2026-11-21', 130, 'http://docs.uni.lk/ict2203');

INSERT INTO Exam_Offering (`Year`, Semester_ID, Course_Code, Exam_Date, Answer_Script_Count, `Status`) 
VALUES 
(2026, 1, 'ICT1101', '2026-06-10', 120, 'Completed'),
(2026, 1, 'ICT1202', '2026-06-12', 140, 'Completed'),
(2026, 1, 'ICT1402', '2026-06-14', 165, 'Completed'),
(2026, 2, 'ICT2101', '2026-11-05', 110, 'Scheduled'),
(2026, 2, 'ICT2203', '2026-11-08', 130, 'Scheduled');

INSERT INTO Employee_Type (`Type`, Description) 
VALUES 
('Dean', 'Dean of the Faculty'),
('HOD', 'Head of the Department'),
('HOD Clerk', 'Clerical staff working under HOD');

INSERT INTO Admin (Employee_ID, `Type`) 
VALUES 
('00010', 'Dean'),      
('00013', 'HOD'),       
('00004', 'HOD Clerk');   

INSERT INTO Admin_Course (Employee_ID, `Year`, Semester_ID, Course_Code, Transaction_Type) 
VALUES 
('00013', 2026, 1, 'ICT1402', 'Assigned HOD Review'),
('00010', 2026, 1, 'ICT1202', 'Dean Approval'),
('00004', 2026, 1, 'ICT1101', 'Data Entry');

INSERT INTO Hand_Over (Employee_ID, Course_Code, `Date`) 
VALUES 
('00013', 'ICT1402', '2026-06-25'),
('00010', 'ICT1202', '2026-06-26'),
('00004', 'ICT1101', '2026-06-27');



INSERT INTO Users (Employee_ID, `Password`) 
VALUES 
('00013', 'hod123'),     -- HoD (Employee ID 00013)
('00010', 'dean123'),    -- Dean (Employee ID 00010)
('00007',  'lic123'),     -- Lecturer in Charge (Employee ID 00007)
('00004',  'sec123'),     -- Second Examiner (Employee ID 00004)
('00005',  'mod123'),     -- Moderator (Employee ID 00005)
('00001',  'ar123');      -- AR (Employee ID 00001)

--Create user profile previlages.

CREATE USER 'hod'@'localhost' IDENTIFIED BY 'hod123';
CREATE USER 'dean'@'localhost' IDENTIFIED BY 'dean123';
CREATE USER 'lic'@'localhost' IDENTIFIED BY 'lic123';
CREATE USER 'sec'@'localhost' IDENTIFIED BY 'sec123';
CREATE USER 'mod'@'localhost' IDENTIFIED BY 'mod123';
CREATE USER 'ar'@'localhost' IDENTIFIED BY 'ar123';

-- Granting privileges to the users
GRANT SELECT, INSERT, UPDATE, DELETE ON ERMS.* TO 'hod'@'localhost';
GRANT SELECT, UPDATE, DELETE ON ERMS.* TO 'dean'@'localhost';
GRANT SELECT, UPDATE ON ERMS.* TO 'lic'@'localhost';
GRANT SELECT,  UPDATE ON ERMS.* TO 'sec'@'localhost';
GRANT SELECT,  UPDATE, DELETE ON ERMS.* TO 'mod'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ERMS.* TO 'ar'@'localhost';


-- Verification Queries
SHOW TABLES;

SELECT * FROM Employee;
SELECT * FROM Employee_Qualification;
SELECT * FROM Semester;
SELECT * FROM Course;
SELECT * FROM Exam_Packet_Tracking;
SELECT * FROM Exam_Offering;
SELECT * FROM Lecturer_in_Charge;
SELECT * FROM Second_Examiner;
SELECT * FROM Moderator;
SELECT * FROM Employee_Type;
SELECT * FROM Admin;
SELECT * FROM Admin_Course;
SELECT * FROM Hand_Over;
SELECT * From Users;


DELIMITER $$

DROP PROCEDURE IF EXISTS Assign_Employee_Privileges$$
CREATE PROCEDURE Assign_Employee_Privileges(
    IN p_employee_id INT,
    IN p_role        VARCHAR(30),
    IN p_password    VARCHAR(20))
BEGIN
    DECLARE v_user  VARCHAR(20);
    DECLARE v_privs VARCHAR(60);

    SET v_user = CONCAT('e', LPAD(p_employee_id, 5, '0'));

    SET v_privs = CASE p_role
        WHEN 'HOD'                THEN 'SELECT, INSERT, UPDATE, DELETE'
        WHEN 'HOD Clerk'          THEN 'SELECT, UPDATE'
        WHEN 'Dean'               THEN 'SELECT, UPDATE, DELETE'
        WHEN 'Lecturer in Charge' THEN 'SELECT, UPDATE'
        WHEN 'Second Examiner'    THEN 'SELECT, UPDATE'
        WHEN 'Moderator'          THEN 'SELECT, UPDATE, DELETE'
        WHEN 'AR Office'          THEN 'SELECT, INSERT, UPDATE, DELETE'
        ELSE NULL
    END;

    IF v_privs IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unknown role: no MySQL privileges were assigned';
    END IF;

    -- create the account (or reset its password when it already exists)
    SET @erms_sql = CONCAT('CREATE USER IF NOT EXISTS ', QUOTE(v_user), '@''localhost'' IDENTIFIED BY ', QUOTE(p_password));
    PREPARE erms_stmt FROM @erms_sql;  EXECUTE erms_stmt;  DEALLOCATE PREPARE erms_stmt;

    SET @erms_sql = CONCAT('ALTER USER ', QUOTE(v_user), '@''localhost'' IDENTIFIED BY ', QUOTE(p_password));
    PREPARE erms_stmt FROM @erms_sql;  EXECUTE erms_stmt;  DEALLOCATE PREPARE erms_stmt;

    -- remove old privileges (role change), then grant the privileges of the new role
    SET @erms_sql = CONCAT('REVOKE ALL PRIVILEGES, GRANT OPTION FROM ', QUOTE(v_user), '@''localhost''');
    PREPARE erms_stmt FROM @erms_sql;  EXECUTE erms_stmt;  DEALLOCATE PREPARE erms_stmt;

    SET @erms_sql = CONCAT('GRANT ', v_privs, ' ON ERMS.* TO ', QUOTE(v_user), '@''localhost''');
    PREPARE erms_stmt FROM @erms_sql;  EXECUTE erms_stmt;  DEALLOCATE PREPARE erms_stmt;
END$$

DROP PROCEDURE IF EXISTS Drop_Employee_Account$$
CREATE PROCEDURE Drop_Employee_Account(IN p_employee_id INT)
BEGIN
    SET @erms_sql = CONCAT('DROP USER IF EXISTS ', QUOTE(CONCAT('e', LPAD(p_employee_id, 5, '0'))), '@''localhost''');
    PREPARE erms_stmt FROM @erms_sql;  EXECUTE erms_stmt;  DEALLOCATE PREPARE erms_stmt;
END$$

-- Adds an employee, the role row, the login AND the MySQL privileges in one call:
--   CALL Add_Employee('Kasun','Perera','No 5','Colombo','kasun@uni.lk','0771234567','Senior Lecturer Grade 2','Moderator','pass1234');
-- Roles: 'Lecturer in Charge','Second Examiner','Moderator','HOD','HOD Clerk','Dean','AR Office'
DROP PROCEDURE IF EXISTS Add_Employee$$
CREATE PROCEDURE Add_Employee(
    IN p_first         VARCHAR(50),
    IN p_last          VARCHAR(50),
    IN p_address1      VARCHAR(50),
    IN p_address2      VARCHAR(50),
    IN p_email         VARCHAR(50),
    IN p_contact       VARCHAR(10),
    IN p_qualification VARCHAR(50),
    IN p_role          VARCHAR(30),
    IN p_password      VARCHAR(20))
BEGIN
    DECLARE v_id INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF p_role NOT IN ('Lecturer in Charge','Second Examiner','Moderator','HOD','HOD Clerk','Dean','AR Office') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unknown role';
    END IF;

    START TRANSACTION;
        INSERT INTO Employee (First_Name, Last_Name, Adress_Line_1, Adress_Line_2, Email, Contact_Number)
        VALUES (p_first, p_last, p_address1, p_address2, p_email, p_contact);
        SET v_id = LAST_INSERT_ID();

        INSERT INTO Employee_Qualification (Employee_ID, Qualification) VALUES (v_id, p_qualification);

        CASE p_role
            WHEN 'Lecturer in Charge' THEN INSERT INTO Lecturer_in_Charge (Employee_ID) VALUES (v_id);
            WHEN 'Second Examiner'    THEN INSERT INTO Second_Examiner (Employee_ID) VALUES (v_id);
            WHEN 'Moderator'          THEN INSERT INTO Moderator (Employee_ID) VALUES (v_id);
            WHEN 'AR Office'          THEN DO 0;
            ELSE                           INSERT INTO `Admin` (Employee_ID, `Type`) VALUES (v_id, p_role);
        END CASE;

        INSERT INTO Users (Employee_ID, `Password`) VALUES (v_id, p_password);
    COMMIT;

    -- CREATE USER / GRANT end the transaction automatically, so they run after the COMMIT
    CALL Assign_Employee_Privileges(v_id, p_role, p_password);

    SELECT v_id AS New_Employee_ID, CONCAT('e', LPAD(v_id, 5, '0')) AS MySQL_Account;
END$$

DELIMITER ;


-- Give the sample employees their own MySQL accounts (same rules as new employees)
CALL Assign_Employee_Privileges(10, 'Dean',               'dean123');
CALL Assign_Employee_Privileges(13, 'HOD',                'hod123');
CALL Assign_Employee_Privileges(7,  'Lecturer in Charge', 'lic123');
CALL Assign_Employee_Privileges(4,  'Second Examiner',    'sec123');
CALL Assign_Employee_Privileges(5,  'Moderator',          'mod123');
CALL Assign_Employee_Privileges(1,  'AR Office',          'ar123');



