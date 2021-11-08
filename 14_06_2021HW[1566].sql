#database name that I am using
use drivers; 

#crating a temp table
create temporary table drivers(licenseID varchar(45), name varchar(45), surname varchar(45),
						phone_number int, cash int, numberPlate varchar(45),
                        color varchar(45), model varchar(45), type varchar(3)); 
 
#creating a stored procedure to check if a table exists
DELIMITER //
CREATE PROCEDURE check_table_exists(table_name VARCHAR(100)) 
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02' SET @err = 1;
    SET @err = 0;
    SET @table_name = table_name;
    SET @sql_query = CONCAT('SELECT 1 FROM ',@table_name);
    PREPARE stmt1 FROM @sql_query;
    IF (@err = 1) THEN
        SET @table_exists = 0;
    ELSE
        SET @table_exists = 1;
        DEALLOCATE PREPARE stmt1;
    END IF;
END //
DELIMITER ;

#calling the check_table_exist procedure to check if the table drivers exists
CALL check_table_exists('drivers');
SELECT @table_exists;


#loading data from a file to the temp table
LOAD DATA INFILE 'c:/drivers.csv' 
INTO TABLE drivers 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

#moving information from drivers to a new table history
CREATE Table history(licenseID varchar(45), name varchar(45), surname varchar(45),
						phone_number int, cash int, numberPlate varchar(45),
                        color varchar(45), model varchar(45), type varchar(3), date datetime, time timestamp);
select *
from drivers;

#renaming table
rename table history to history_driver;

#creating a view for history_driver
create view history_view as
select *
from history_driver;

#dropping the temporary table
drop temporary table drivers;


