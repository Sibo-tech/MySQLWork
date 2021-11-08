#creating a stored procedure to check if a table exists
DELIMITER //
CREATE PROCEDURE sibo_load_file(file_name VARCHAR(100)) 
BEGIN
    #DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02' SET @err = 1;
    #SET @err = 0;
    #SET @file_name = file_name;
    #SET @sql_query = CONCAT('SELECT 1 FROM ',@table_name);
    #PREPARE stmt1 FROM @sql_query;
   # IF (@err = 1) THEN
   #     SET @table_exists = 0;
    #ELSE
     #   SET @table_exists = 1;
      #  DEALLOCATE PREPARE stmt1;
    #END IF;
    
#creating a temp table  
drop temporary table drivers;  
create temporary table drivers(licenseID varchar(45), name varchar(45), surname varchar(45),
						phone_number int, cash int, numberPlate varchar(45),
                        color varchar(45), model varchar(45), type varchar(3)); 
 
 #check if the file exists
 
#loading data from a file to the temp table
#LOAD DATA INFILE @file_name

#LOAD DATA INFILE 'c:/drivers.csv' 
#INTO TABLE drivers 
#FIELDS TERMINATED BY ',' 
#ENCLOSED BY '"'
#LINES TERMINATED BY '\n'
#IGNORE 1 ROWS;

#
insert into drivers
Select *
FROM new_drivers;

#rename the file that we load

#adding data to the history table from drivers
insert into history (licenseID, name, surname, phone_number , cash , numberPlate , color , model , type , date, time )
select *, current_timestamp()
from drivers;

END //
DELIMITER ;

Call sibo_load_file('');

