CREATE DATABASE IF NOT EXISTS university ;
USE university;

CREATE TABLE IF NOT EXISTS departments (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id));

INSERT INTO departments (name) VALUES 
("ИКПИ-11"),
("ИКПИ-14");

CREATE TABLE IF NOT EXISTS users (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  d_id INT,
  PRIMARY KEY (id));

INSERT INTO users (name, d_id) VALUES 
("Ivan", 1),
("Ivan1", 1),
("Ivan2", 2),
("Ivan3", 2),
("Ivan4", 2);

SELECT * FROM departments;
SELECT * FROM users;

DROP procedure IF EXISTS getUserInfo;
DELIMITER $$
CREATE PROCEDURE getUserInfo (IN param1 VARCHAR(45), OUT param2 INT) 
BEGIN 
    DECLARE UserName VARCHAR(45); 
    SET UserName = 'Ivan'; 
    
    IF param1 IS NOT NULL THEN 
        SET UserName = param1; 
    END IF; 
    
    SELECT d.name INTO @department FROM users u LEFT JOIN departments d ON u.d_id = d.id WHERE u.name = UserName; 
    SELECT COUNT(*) INTO param2 FROM users; 
END$$
DELIMITER ;

SELECT * from departments;
SELECT * FROM users;
CALL getUserInfo(NULL, @total);
SELECT @department;
SELECT @total;
CALL getUserInfo('Ivan3', @total);
SELECT @department;
SELECT @total;
