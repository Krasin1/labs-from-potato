CREATE SCHEMA IF NOT EXISTS `l1`;
USE l1;

CREATE TABLE IF NOT EXISTS `l1`.`students` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `d_id` INT NULL,
  PRIMARY KEY (`id`));
  
INSERT INTO `l1`.`students` (`id`, `name`, `d_id`) VALUES ('1', 'student1', '5');
INSERT INTO `l1`.`students` (`id`, `name`, `d_id`) VALUES ('2', 'student2', '4');
INSERT INTO `l1`.`students` (`id`, `name`, `d_id`) VALUES ('3', 'student3', '3');
INSERT INTO `l1`.`students` (`id`, `name`, `d_id`) VALUES ('4', 'student4', '2');
INSERT INTO `l1`.`students` (`id`, `name`, `d_id`) VALUES ('5', 'student5', '1');

SELECT * FROM students;
UPDATE l1.students SET name = 'Ivan' WHERE ID = 2;
SELECT * FROM students WHERE id = 2;
DELETE FROM students WHERE id = 2;
SELECT * FROM students;

CREATE TABLE IF NOT EXISTS `l1`.`departments` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
  
INSERT INTO `l1`.`departments` (`id`, `name`) VALUES ('1', 'РТС');
INSERT INTO `l1`.`departments` (`id`, `name`) VALUES ('2', 'ИКСС');
INSERT INTO `l1`.`departments` (`id`, `name`) VALUES ('3', 'ИСиТ');
INSERT INTO `l1`.`departments` (`id`, `name`) VALUES ('4', 'ФФП');
INSERT INTO `l1`.`departments` (`id`, `name`) VALUES ('5', 'ЦЭУБИ');

SELECT * FROM departments;

CREATE TABLE IF NOT EXISTS`l1`.`users` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `d_id` INT NULL,
  PRIMARY KEY (`id`));

INSERT INTO `l1`.`users` (`id`, `name`, `d_id`) VALUES ('1', 'user1', '7');
INSERT INTO `l1`.`users` (`id`, `name`, `d_id`) VALUES ('2', 'user2', '6');
INSERT INTO `l1`.`users` (`id`, `name`, `d_id`) VALUES ('3', 'user3', '5');
INSERT INTO `l1`.`users` (`id`, `name`, `d_id`) VALUES ('4', 'user4', '4');
INSERT INTO `l1`.`users` (`id`, `name`, `d_id`) VALUES ('5', 'user5', '3');
INSERT INTO `l1`.`users` (`id`, `name`, `d_id`) VALUES ('6', 'user6', '2');
INSERT INTO `l1`.`users` (`id`, `name`, `d_id`) VALUES ('7', 'user7', '1');

SELECT * FROM departments;
SELECT * FROM users;
SELECT u.id, u.name, d.name FROM users u INNER JOIN departments d ON u.d_id = d.id;
SELECT u.id, u.name, d.name FROM users u LEFT JOIN departments d ON u.d_id = d.id;
SELECT u.id, u.name, d.name FROM users u RIGHT JOIN departments d ON u.d_id = d.id;
SELECT u.id, u.name, d.name FROM users u CROSS JOIN departments d;
