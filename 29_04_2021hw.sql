use sibongiledb;

SELECT s.*
FROM   sibongile s
LIMIT  20; 

#creating a stored procedure to check if a table exists
use test;

-- creating a stored procedure that removes or add a letter to the begining of the table name
DELIMITER //

CREATE PROCEDURE prefix_all (in_db varchar(20),tbl_nm VARCHAR(30),in_prefix varchar(10),in_add_rem TINYINT(1))
BEGIN

DECLARE done INT default 0;
DECLARE ren VARCHAR(200);

DECLARE table_cur CURSOR FOR select table_name from information_schema.tables where table_schema=in_db;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

OPEN table_cur;
if @table_exist=1 then
	      SET @ren = concat("rename table ", in_db,'.',tbl_nm ," to ",in_db,'.',in_prefix,tbl_nm,";");
          end if;
    if in_add_rem=1 then #ADD
      SET @ren = concat("rename table ", in_db,'.',tbl_nm ," to ",in_db,'.',in_prefix,tbl_nm,";");
	end if;
	if in_add_rem=0 then #remove
      set @ren= concat("rename table ", in_db,'.',tbl_nm ," to ",in_db,'.',right(tbl_nm,length(tbl_nm)-length(in_prefix)),';');
    end if;
    prepare ren from @ren;
    execute ren;
CLOSE table_cur;
select table_name 'Tables', now() from information_schema.tables where table_schema=in_db;

END //

DELIMITER ;


-- creating an event to all the stored procedure prefix_all() at midnight
   CREATE EVENT rename_table
ON SCHEDULE EVERY '1' DAY
  STARTS '2021-05-04 00:00:00' 
  ENDs '2022-05-03 00:00:00'
  DO
call test.prefix_all('test','ttable','t',1);
