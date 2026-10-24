DROP DATABASE IF EXISTS ERMS;

CREATE DATABASE IF NOT EXISTS ERMS
    CHARACTER SET utf8mb4 /*CHARACTER SET utf8mb4;*/
    COLLATE utf8mb4_unicode_ci;

USE ERMS;

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

--=============================Create user profile privileges.=======================================

CREATE USER 'hod'@'localhost' IDENTIFIED BY 'hod123';
CREATE USER 'dean'@'localhost' IDENTIFIED BY 'dean123';
CREATE USER 'lic'@'localhost' IDENTIFIED BY 'lic123';
CREATE USER 'sec'@'localhost' IDENTIFIED BY 'sec123';
CREATE USER 'mod'@'localhost' IDENTIFIED BY 'mod123';
CREATE USER 'ar'@'localhost' IDENTIFIED BY 'ar123';

--============================Granting privileges to the users.=======================================
GRANT SELECT, INSERT, UPDATE, DELETE ON ERMS.* TO 'hod'@'localhost';
GRANT SELECT, UPDATE, DELETE ON ERMS.* TO 'dean'@'localhost';
GRANT SELECT, UPDATE ON ERMS.* TO 'lic'@'localhost';
GRANT SELECT,  UPDATE ON ERMS.* TO 'sec'@'localhost';
GRANT SELECT,  UPDATE, DELETE ON ERMS.* TO 'mod'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ERMS.* TO 'ar'@'localhost';


--===============================Verification Queries=================================================
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



-- ==================== SECURITY FOUNDATION  ====================
-- All security limits live in ONE table so they can be tuned without touching code.
CREATE TABLE IF NOT EXISTS Security_Policy (
    Policy_Name  VARCHAR(40) PRIMARY KEY,
    Policy_Value INT NOT NULL,
    Description  VARCHAR(120) NOT NULL
) ENGINE = InnoDB;

INSERT INTO Security_Policy (Policy_Name, Policy_Value, Description) VALUES
 ('min_length',          8,  'Minimum password length'),
 ('max_length',          20, 'Maximum password length'),
 ('max_failed_attempts', 3,  'Wrong passwords allowed before the account is locked'),
 ('lock_minutes',        15, 'Minutes an ERMS login stays locked after too many failures'),
 ('password_valid_days', 90, 'Days before a password expires (use 1 for a quick demo)')
ON DUPLICATE KEY UPDATE Description = VALUES(Description);

DELIMITER $$

DROP FUNCTION IF EXISTS fn_policy$$
CREATE FUNCTION fn_policy(p_name VARCHAR(40)) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v INT;
    SELECT Policy_Value INTO v FROM Security_Policy WHERE Policy_Name = p_name;
    RETURN v;
END$$

-- salted SHA-256 hash, stored as  salt$hash  (81 characters)
DROP FUNCTION IF EXISTS fn_hash_password$$
CREATE FUNCTION fn_hash_password(p_pw VARCHAR(100)) RETURNS VARCHAR(100)
NOT DETERMINISTIC NO SQL
BEGIN
    DECLARE v_salt CHAR(16);
    SET v_salt = LOWER(HEX(RANDOM_BYTES(8)));
    RETURN CONCAT(v_salt, '$', SHA2(CONCAT(v_salt, p_pw), 256));
END$$

DROP FUNCTION IF EXISTS fn_check_password$$
CREATE FUNCTION fn_check_password(p_stored VARCHAR(100), p_pw VARCHAR(100)) RETURNS TINYINT
DETERMINISTIC NO SQL
BEGIN
    DECLARE v_salt VARCHAR(16);
    IF p_stored IS NULL OR LOCATE('$', p_stored) = 0 THEN RETURN 0; END IF;
    SET v_salt = SUBSTRING_INDEX(p_stored, '$', 1);
    RETURN IF(BINARY p_stored = BINARY CONCAT(v_salt, '$', SHA2(CONCAT(v_salt, p_pw), 256)), 1, 0);
END$$

DELIMITER ;

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

    -- security rules for every employee account: SSL required, password expiry, lock after failed logins
    -- (PASSWORD_LOCK_TIME of a MySQL account is counted in days)
    SET @erms_sql = CONCAT('ALTER USER ', QUOTE(v_user), '@''localhost'' REQUIRE SSL',
        ' PASSWORD EXPIRE INTERVAL ', fn_policy('password_valid_days'), ' DAY',
        ' FAILED_LOGIN_ATTEMPTS ', fn_policy('max_failed_attempts'),
        ' PASSWORD_LOCK_TIME 1');
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







-- ============================================================================
-- ==================== SECURITY FEATURES (all 4 steps) =======================
-- ============================================================================
-- Needs MySQL 8.0.19 or newer.  Run the whole file as root.


-- ----------------------------------------------------------------------------
-- 1. DATA MASKING WITH VIEWS
-- ----------------------------------------------------------------------------
-- Contact number: only the last 3 digits are visible.  E-mail: first 2 letters + domain.
CREATE OR REPLACE VIEW v_employee_safe AS
SELECT
    Employee_ID,
    First_Name,
    Last_Name,
    CONCAT(LEFT(Email, 2), '***', SUBSTRING(Email, LOCATE('@', Email))) AS Masked_Email,
    CONCAT('*******', RIGHT(Contact_Number, 3))                        AS Masked_Contact_Number
FROM Employee;

-- Full read-only directory used by the Dean screen (addresses hidden, e-mail / phone masked)
CREATE OR REPLACE VIEW v_employee_directory_masked AS
SELECT
    e.Employee_ID                                                       AS Employee_ID,
    e.First_Name                                                        AS First_Name,
    e.Last_Name                                                         AS Last_Name,
    '********'                                                          AS Adress_Line_1,
    '********'                                                          AS Adress_Line_2,
    CONCAT(LEFT(e.Email, 2), '***', SUBSTRING(e.Email, LOCATE('@', e.Email))) AS Email,
    CONCAT('*******', RIGHT(e.Contact_Number, 3))                       AS Contact_Number
FROM Employee e;

-- Login accounts without the password hash
CREATE OR REPLACE VIEW v_users_safe AS
SELECT Employee_ID,
       IF(Locked_Until IS NOT NULL AND Locked_Until > NOW(), 'LOCKED', 'ACTIVE') AS Account_Status,
       IF(Password_Expires_At < NOW(), 'EXPIRED', 'VALID')                       AS Password_Status,
       Password_Expires_At
FROM Users;

CREATE USER IF NOT EXISTS 'erms_auditor'@'localhost' IDENTIFIED BY 'ReplaceWithAStrongPassword!1';
GRANT SELECT ON ERMS.v_employee_safe            TO 'erms_auditor'@'localhost';
GRANT SELECT ON ERMS.v_employee_directory_masked TO 'erms_auditor'@'localhost';
GRANT SELECT ON ERMS.v_users_safe               TO 'erms_auditor'@'localhost';


-- ----------------------------------------------------------------------------
-- 2. PASSWORD RULES + ACCOUNT LOCK
-- ----------------------------------------------------------------------------
-- (a) New columns on Users.  The password column is widened because it now holds a salted hash.
ALTER TABLE Users
    MODIFY COLUMN `Password` VARCHAR(100) NOT NULL,
    ADD COLUMN Password_Expires_At DATETIME NULL,
    ADD COLUMN Failed_Attempts     INT NOT NULL DEFAULT 0,
    ADD COLUMN Locked_Until        DATETIME NULL;

-- (b) Existing demo passwords are hashed once (they were inserted before the rules existed,
--     so they are accepted as they are; the next password change must follow the rules).
UPDATE Users
SET `Password`          = fn_hash_password(`Password`),
    Password_Expires_At = DATE_ADD(NOW(), INTERVAL fn_policy('password_valid_days') DAY);

-- (c) Audit log for security events (used by the lock-out and the triggers below)
CREATE TABLE IF NOT EXISTS Audit_Log (
    Audit_ID    BIGINT AUTO_INCREMENT PRIMARY KEY,
    Table_Name  VARCHAR(40)  NOT NULL,
    Action_Type VARCHAR(20)  NOT NULL,
    Record_Key  VARCHAR(80)  NOT NULL,
    Details     VARCHAR(400) NULL,
    Changed_By  VARCHAR(288) NULL,
    Changed_At  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

DELIMITER $$

-- (d) Password rules: 8-20 characters, upper + lower case, a digit, a special character, no spaces
DROP PROCEDURE IF EXISTS Validate_Password$$
CREATE PROCEDURE Validate_Password(IN p_pw VARCHAR(100))
BEGIN
    IF p_pw IS NULL OR CHAR_LENGTH(p_pw) < fn_policy('min_length') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password must be at least 8 characters long.';
    END IF;
    IF CHAR_LENGTH(p_pw) > fn_policy('max_length') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password must be at most 20 characters long.';
    END IF;
    IF NOT REGEXP_LIKE(p_pw, '[A-Z]', 'c') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password must contain an upper-case letter.';
    END IF;
    IF NOT REGEXP_LIKE(p_pw, '[a-z]', 'c') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password must contain a lower-case letter.';
    END IF;
    IF NOT REGEXP_LIKE(p_pw, '[0-9]') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password must contain a digit.';
    END IF;
    IF NOT REGEXP_LIKE(p_pw, '[^A-Za-z0-9]') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password must contain a special character (for example @ # $ !).';
    END IF;
    IF REGEXP_LIKE(p_pw, '[[:space:]]') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password must not contain spaces.';
    END IF;
END$$

-- (e) Triggers: every new / changed password is checked, hashed and given a new expiry date
DROP TRIGGER IF EXISTS trg_users_set_password_expiry_insert$$
DROP TRIGGER IF EXISTS trg_users_set_password_expiry_update$$
DROP TRIGGER IF EXISTS trg_users_password_insert$$
DROP TRIGGER IF EXISTS trg_users_password_update$$

CREATE TRIGGER trg_users_password_insert
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
    CALL Validate_Password(NEW.`Password`);
    SET NEW.`Password`          = fn_hash_password(NEW.`Password`);
    SET NEW.Password_Expires_At = DATE_ADD(NOW(), INTERVAL fn_policy('password_valid_days') DAY);
END$$

CREATE TRIGGER trg_users_password_update
BEFORE UPDATE ON Users
FOR EACH ROW
BEGIN
    IF NOT (OLD.`Password` <=> NEW.`Password`) THEN
        CALL Validate_Password(NEW.`Password`);
        SET NEW.`Password`          = fn_hash_password(NEW.`Password`);
        SET NEW.Password_Expires_At = DATE_ADD(NOW(), INTERVAL fn_policy('password_valid_days') DAY);
        SET NEW.Failed_Attempts     = 0;
        SET NEW.Locked_Until        = NULL;
    END IF;
END$$

-- (f) Login check used by the application: returns ONE row  (Status, Detail)
--     Status = OK | EXPIRED | BAD (Detail = attempts left) | LOCKED (Detail = minutes left)
DROP PROCEDURE IF EXISTS Login_Check$$
CREATE PROCEDURE Login_Check(IN p_id INT, IN p_pw VARCHAR(100))
BEGIN
    DECLARE v_stored VARCHAR(100);
    DECLARE v_fail   INT;
    DECLARE v_lock   DATETIME;
    DECLARE v_exp    DATETIME;
    DECLARE v_max    INT;
    DECLARE v_mins   INT;

    SET v_max  = fn_policy('max_failed_attempts');
    SET v_mins = fn_policy('lock_minutes');

    SELECT `Password`, Failed_Attempts, Locked_Until, Password_Expires_At
      INTO v_stored, v_fail, v_lock, v_exp
      FROM Users WHERE Employee_ID = p_id;

    IF v_stored IS NULL THEN
        SELECT 'BAD' AS Status, CAST(0 AS SIGNED) AS Detail;          -- unknown ID: same answer as a wrong password
    ELSEIF v_lock IS NOT NULL AND v_lock > NOW() THEN
        SELECT 'LOCKED' AS Status, CAST(CEIL(TIMESTAMPDIFF(SECOND, NOW(), v_lock) / 60) AS SIGNED) AS Detail;
    ELSEIF fn_check_password(v_stored, p_pw) = 1 THEN
        UPDATE Users SET Failed_Attempts = 0, Locked_Until = NULL WHERE Employee_ID = p_id;
        IF v_exp IS NOT NULL AND v_exp < NOW() THEN
            SELECT 'EXPIRED' AS Status, CAST(0 AS SIGNED) AS Detail;
        ELSE
            SELECT 'OK' AS Status, CAST(0 AS SIGNED) AS Detail;
        END IF;
    ELSE
        SET v_fail = v_fail + 1;
        IF v_fail >= v_max THEN
            UPDATE Users
               SET Failed_Attempts = 0, Locked_Until = DATE_ADD(NOW(), INTERVAL v_mins MINUTE)
             WHERE Employee_ID = p_id;
            INSERT INTO Audit_Log (Table_Name, Action_Type, Record_Key, Details, Changed_By)
            VALUES ('Users', 'LOCKED', p_id, CONCAT('Account locked for ', v_mins, ' minutes after ', v_max, ' failed logins'), USER());
            SELECT 'LOCKED' AS Status, CAST(v_mins AS SIGNED) AS Detail;
        ELSE
            UPDATE Users SET Failed_Attempts = v_fail WHERE Employee_ID = p_id;
            SELECT 'BAD' AS Status, CAST(v_max - v_fail AS SIGNED) AS Detail;
        END IF;
    END IF;
END$$

-- (g) Change password (also used when the password has expired).  The Users trigger enforces the rules.
DROP PROCEDURE IF EXISTS Change_Password$$
CREATE PROCEDURE Change_Password(IN p_id INT, IN p_old VARCHAR(100), IN p_new VARCHAR(100))
BEGIN
    DECLARE v_stored VARCHAR(100);
    DECLARE v_user   VARCHAR(20);

    SELECT `Password` INTO v_stored FROM Users WHERE Employee_ID = p_id;
    IF v_stored IS NULL OR fn_check_password(v_stored, p_old) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The current password is incorrect.';
    END IF;
    IF BINARY p_old = BINARY p_new THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The new password must be different from the current one.';
    END IF;

    UPDATE Users SET `Password` = p_new WHERE Employee_ID = p_id;   -- trigger: rules + hash + new expiry

    -- keep the employee's own MySQL account (e00010 ...) in step, if it exists
    SET v_user = CONCAT('e', LPAD(p_id, 5, '0'));
    SET @erms_sql = CONCAT('ALTER USER IF EXISTS ', QUOTE(v_user), '@''localhost'' IDENTIFIED BY ', QUOTE(p_new));
    PREPARE erms_stmt FROM @erms_sql;  EXECUTE erms_stmt;  DEALLOCATE PREPARE erms_stmt;
END$$

-- (h) Administrator unlock:   CALL Unlock_Account(13);
DROP PROCEDURE IF EXISTS Unlock_Account$$
CREATE PROCEDURE Unlock_Account(IN p_id INT)
BEGIN
    UPDATE Users SET Failed_Attempts = 0, Locked_Until = NULL WHERE Employee_ID = p_id;
    INSERT INTO Audit_Log (Table_Name, Action_Type, Record_Key, Details, Changed_By)
    VALUES ('Users', 'UNLOCKED', p_id, 'Account unlocked by administrator', USER());
END$$

DELIMITER ;

-- (i) The MySQL accounts of the employees (e00001 ...) get the same rules from Assign_Employee_Privileges
--     (password expiry, 3 failed attempts -> locked for 1 day, SSL required).  Nothing more to do here.


-- ----------------------------------------------------------------------------
-- 3. AUDIT CHANGES WITH TRIGGERS
-- ----------------------------------------------------------------------------
-- The application stores the signed-in employee in @erms_user; USER() is the MySQL account.
CREATE TABLE IF NOT EXISTS Exam_Offering_Audit (
    Audit_ID         BIGINT AUTO_INCREMENT PRIMARY KEY,
    Action_Type      VARCHAR(10) NOT NULL DEFAULT 'UPDATE',
    `Year`           INT NOT NULL,
    Semester_ID      INT NOT NULL,
    Course_Code      VARCHAR(10) NOT NULL,
    Old_Exam_Date    DATE,
    New_Exam_Date    DATE,
    Old_Script_Count INT,
    New_Script_Count INT,
    Old_Status       VARCHAR(20),
    New_Status       VARCHAR(20),
    Changed_By       VARCHAR(288),
    Changed_At       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

DELIMITER $$

DROP TRIGGER IF EXISTS trg_exam_offering_audit$$
DROP TRIGGER IF EXISTS trg_exam_offering_audit_update$$
DROP TRIGGER IF EXISTS trg_exam_offering_audit_insert$$
DROP TRIGGER IF EXISTS trg_exam_offering_audit_delete$$

CREATE TRIGGER trg_exam_offering_audit_update
AFTER UPDATE ON Exam_Offering
FOR EACH ROW
BEGIN
    IF NOT (OLD.Exam_Date <=> NEW.Exam_Date)
       OR NOT (OLD.Answer_Script_Count <=> NEW.Answer_Script_Count)
       OR NOT (OLD.`Status` <=> NEW.`Status`) THEN
        INSERT INTO Exam_Offering_Audit
            (Action_Type, `Year`, Semester_ID, Course_Code, Old_Exam_Date, New_Exam_Date,
             Old_Script_Count, New_Script_Count, Old_Status, New_Status, Changed_By)
        VALUES
            ('UPDATE', OLD.`Year`, OLD.Semester_ID, OLD.Course_Code, OLD.Exam_Date, NEW.Exam_Date,
             OLD.Answer_Script_Count, NEW.Answer_Script_Count, OLD.`Status`, NEW.`Status`,
             CONCAT(IFNULL(@erms_user, 'unknown'), ' via ', USER()));
    END IF;
END$$

CREATE TRIGGER trg_exam_offering_audit_insert
AFTER INSERT ON Exam_Offering
FOR EACH ROW
BEGIN
    INSERT INTO Exam_Offering_Audit
        (Action_Type, `Year`, Semester_ID, Course_Code, New_Exam_Date, New_Script_Count, New_Status, Changed_By)
    VALUES
        ('INSERT', NEW.`Year`, NEW.Semester_ID, NEW.Course_Code, NEW.Exam_Date, NEW.Answer_Script_Count, NEW.`Status`,
         CONCAT(IFNULL(@erms_user, 'unknown'), ' via ', USER()));
END$$

CREATE TRIGGER trg_exam_offering_audit_delete
AFTER DELETE ON Exam_Offering
FOR EACH ROW
BEGIN
    INSERT INTO Exam_Offering_Audit
        (Action_Type, `Year`, Semester_ID, Course_Code, Old_Exam_Date, Old_Script_Count, Old_Status, Changed_By)
    VALUES
        ('DELETE', OLD.`Year`, OLD.Semester_ID, OLD.Course_Code, OLD.Exam_Date, OLD.Answer_Script_Count, OLD.`Status`,
         CONCAT(IFNULL(@erms_user, 'unknown'), ' via ', USER()));
END$$

-- Employee personal data and login accounts (password values are NEVER written to the log)
DROP TRIGGER IF EXISTS trg_employee_audit_update$$
CREATE TRIGGER trg_employee_audit_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF NOT (OLD.First_Name <=> NEW.First_Name) OR NOT (OLD.Last_Name <=> NEW.Last_Name)
       OR NOT (OLD.Adress_Line_1 <=> NEW.Adress_Line_1) OR NOT (OLD.Adress_Line_2 <=> NEW.Adress_Line_2)
       OR NOT (OLD.Email <=> NEW.Email) OR NOT (OLD.Contact_Number <=> NEW.Contact_Number) THEN
        INSERT INTO Audit_Log (Table_Name, Action_Type, Record_Key, Details, Changed_By)
        VALUES ('Employee', 'UPDATE', OLD.Employee_ID,
                CONCAT_WS('; ',
                    IF(OLD.First_Name <=> NEW.First_Name, NULL, 'First name changed'),
                    IF(OLD.Last_Name <=> NEW.Last_Name, NULL, 'Last name changed'),
                    IF(OLD.Adress_Line_1 <=> NEW.Adress_Line_1 AND OLD.Adress_Line_2 <=> NEW.Adress_Line_2, NULL, 'Address changed'),
                    IF(OLD.Email <=> NEW.Email, NULL, CONCAT('Email: ', OLD.Email, ' -> ', NEW.Email)),
                    IF(OLD.Contact_Number <=> NEW.Contact_Number, NULL, 'Contact number changed')),
                CONCAT(IFNULL(@erms_user, 'unknown'), ' via ', USER()));
    END IF;
END$$

DROP TRIGGER IF EXISTS trg_employee_audit_delete$$
CREATE TRIGGER trg_employee_audit_delete
AFTER DELETE ON Employee
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Action_Type, Record_Key, Details, Changed_By)
    VALUES ('Employee', 'DELETE', OLD.Employee_ID, CONCAT('Deleted ', OLD.First_Name, ' ', OLD.Last_Name),
            CONCAT(IFNULL(@erms_user, 'unknown'), ' via ', USER()));
END$$

DROP TRIGGER IF EXISTS trg_users_audit_password$$
CREATE TRIGGER trg_users_audit_password
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    IF NOT (OLD.`Password` <=> NEW.`Password`) THEN
        INSERT INTO Audit_Log (Table_Name, Action_Type, Record_Key, Details, Changed_By)
        VALUES ('Users', 'PASSWORD', OLD.Employee_ID, 'Password changed',
                CONCAT(IFNULL(@erms_user, 'unknown'), ' via ', USER()));
    END IF;
END$$

DROP TRIGGER IF EXISTS trg_users_audit_insert$$
CREATE TRIGGER trg_users_audit_insert
AFTER INSERT ON Users
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (Table_Name, Action_Type, Record_Key, Details, Changed_By)
    VALUES ('Users', 'INSERT', NEW.Employee_ID, 'Login account created',
            CONCAT(IFNULL(@erms_user, 'unknown'), ' via ', USER()));
END$$

DELIMITER ;

-- Read-only access to the audit trail for the auditor account
GRANT SELECT ON ERMS.Exam_Offering_Audit TO 'erms_auditor'@'localhost';
GRANT SELECT ON ERMS.Audit_Log            TO 'erms_auditor'@'localhost';


-- ----------------------------------------------------------------------------
-- 4. BACKUP, RECOVERY AND ENCRYPTION
-- ----------------------------------------------------------------------------
-- (a) Encryption in transit: every employee MySQL account REQUIRES SSL
--     (done inside Assign_Employee_Privileges, so new employees get it automatically).
--     Applied once more here, in case an account was created by an older script:
ALTER USER IF EXISTS 'e00010'@'localhost' REQUIRE SSL;
ALTER USER IF EXISTS 'e00013'@'localhost' REQUIRE SSL;
ALTER USER IF EXISTS 'e00007'@'localhost' REQUIRE SSL;
ALTER USER IF EXISTS 'e00004'@'localhost' REQUIRE SSL;
ALTER USER IF EXISTS 'e00005'@'localhost' REQUIRE SSL;
ALTER USER IF EXISTS 'e00001'@'localhost' REQUIRE SSL;

-- (b) Encryption at rest (OPTIONAL - needs a keyring component, see backup/README_SECURITY.md).
--     Run these lines only after the keyring is set up:
--       ALTER TABLE Employee ENCRYPTION = 'Y';
--       ALTER TABLE Users    ENCRYPTION = 'Y';
--       ALTER TABLE Audit_Log ENCRYPTION = 'Y';

-- (c) Backup user: can read everything and dump routines / triggers, nothing else
CREATE USER IF NOT EXISTS 'erms_backup'@'localhost' IDENTIFIED BY 'ReplaceWithAStrongPassword!2'
    REQUIRE SSL;
GRANT SELECT, SHOW VIEW, TRIGGER, EVENT, LOCK TABLES ON ERMS.* TO 'erms_backup'@'localhost';
GRANT PROCESS, SHOW_ROUTINE ON *.* TO 'erms_backup'@'localhost';   -- SHOW_ROUTINE needs MySQL 8.0.20+

-- (d) Backup log table + recovery check (the actual dump / restore is done by backup\*.bat)
CREATE TABLE IF NOT EXISTS Backup_Log (
    Backup_ID   INT AUTO_INCREMENT PRIMARY KEY,
    File_Name   VARCHAR(200) NOT NULL,
    Backup_Type VARCHAR(20)  NOT NULL DEFAULT 'FULL',
    Encrypted   TINYINT      NOT NULL DEFAULT 1,
    Created_At  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Created_By  VARCHAR(100) NULL
) ENGINE = InnoDB;

-- ==================== VERIFY ALL FOUR FEATURES ====================
-- 1  Masking :   SELECT * FROM v_employee_safe LIMIT 3;
-- 2  Rules   :   CALL Change_Password(7, 'lic123', 'weak');          -- must fail
--                CALL Change_Password(7, 'lic123', 'Lic@12345');     -- must work
--                CALL Login_Check(7, 'wrong');  (x3)                 -- 3rd call returns LOCKED
-- 3  Audit   :   UPDATE Exam_Offering SET Answer_Script_Count = 121 WHERE Course_Code = 'ICT1101';
--                SELECT * FROM Exam_Offering_Audit;  SELECT * FROM Audit_Log;
-- 4  Backup  :   run backup\erms_backup.bat then backup\erms_restore.bat


-- ==================== FINAL CHECK (all results should say OK) ====================
SELECT 'Masking view'    AS Feature, IF(COUNT(*) > 0, 'OK', 'FAIL') AS Result FROM v_employee_safe
UNION ALL
SELECT 'Login procedure', IF(COUNT(*) = 4, 'OK', 'FAIL') FROM information_schema.ROUTINES
  WHERE ROUTINE_SCHEMA = DATABASE() AND ROUTINE_NAME IN ('Login_Check','Change_Password','Validate_Password','Unlock_Account')
UNION ALL
SELECT 'Passwords hashed', IF(SUM(CHAR_LENGTH(`Password`) = 81) = COUNT(*), 'OK', 'FAIL') FROM Users
UNION ALL
SELECT 'Demo login hod123', IF(fn_check_password(`Password`, 'hod123') = 1, 'OK', 'FAIL') FROM Users WHERE Employee_ID = 13
UNION ALL
SELECT 'Audit triggers', IF(COUNT(*) >= 8, 'OK', 'FAIL') FROM information_schema.TRIGGERS WHERE TRIGGER_SCHEMA = DATABASE()
UNION ALL
SELECT 'Backup user', IF(COUNT(*) = 1, 'OK', 'FAIL') FROM mysql.user WHERE User = 'erms_backup';
