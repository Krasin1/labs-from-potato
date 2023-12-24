CREATE DATABASE IF NOT EXISTS university;
USE university;

CREATE TABLE tasks (
	id INT NOT NULL AUTO_INCREMENT,
    taskname VARCHAR(45) NOT NULL,
    taskmonth VARCHAR(45),
    taskday VARCHAR(45),
    u_id INT,
    PRIMARY KEY(id)
);

SELECT * FROM tasks;

DROP PROCEDURE IF EXISTS createTask;
DELIMITER //
CREATE PROCEDURE createTask(IN tname VARCHAR(45), IN tdate DATETIME, OUT muchdays VARCHAR(45))
BEGIN
	DECLARE tmonth VARCHAR(45);
    SELECT CONCAT('Task month is: ',
		(CASE MONTH(tdate)
			WHEN 1 THEN 'Jan'
            WHEN 2 THEN 'Feb'
            WHEN 3 THEN 'Mar'
            WHEN 4 THEN 'Arp'
            WHEN 5 THEN 'May'
            WHEN 6 THEN 'Jun'
            WHEN 7 THEN 'Jul'
            WHEN 8 THEN 'Aug'
            WHEN 9 THEN 'Sep'
            WHEN 10 THEN 'Oct'
            WHEN 11 THEN 'Nov'
            WHEN 12 THEN 'Dec'
            ELSE 'None'
            END
		)) INTO tmonth;
	INSERT INTO tasks (taskname, taskday, taskmonth) VALUES (tname, DAY(tdate), tmonth);
    SELECT CONCAT(' remain days: ', DATEDIFF(tdate, CURDATE())) INTO muchdays;
END //
DELIMITER ;

CALL createTask('Database optimization', '2009-11-01', @days); 
SELECT CONCAT('Optimization', @days); 
CALL createTask('Database replication', '2009-09-14', @days); 
SELECT CONCAT('Replication', @days); 
CALL createTask('New task', '2023-01-01', @days); 
SELECT CONCAT('task', @days); 
SELECT * FROM tasks;
