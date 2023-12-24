DROP DATABASE IF EXISTS university;
CREATE DATABASE IF NOT EXISTS university;
USE university;

CREATE TABLE IF NOT EXISTS users (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  d_id INT,
  PRIMARY KEY (`id`));

INSERT INTO users (name, d_id) 
VALUES 	("Ivan", 1),
		("Ivan1", 1),
		("Ivan2", 2),
		("Ivan3", 2),
		("Ivan4", 2);
        
SELECT * FROM users;

SET AUTOCOMMIT = 0;
SELECT * FROM users;
DELETE FROM users;
SELECT * FROM users;
ROLLBACK;
SELECT * FROM users;

START TRANSACTION;
SAVEPOINT sve_point;
DELETE FROM users;
SELECT * FROM users;
ROLLBACK TO SAVEPOINT sve_point;
SELECT * FROM users;
DELETE FROM users;
SELECT * FROM users;





