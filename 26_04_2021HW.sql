-- new schema/database
create schema `test`;

-- backup of a table
create table test_table as 
select *
from sql_store.customers;

-- create a store procedure that counts the number of fields
DELIMITER //
create procedure count_fields(out total INT, out time_at datetime)
	begin 
		select count(*)
        into total
        from test_table;
	END //
DELIMITER ;

-- create event to count and check the time for last count
CREATE EVENT test_event
	ON SCHEDULE AT CURRENT_TIMESTAMP
		DO
			Call count_fields(@total, time_at);
			select @total, now();

-- drop the event when done
drop event test_event;

CREATE TABLE logtb (
    id INT PRIMARY KEY AUTO_INCREMENT,
    message VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL
);

-- create event to log and record the time for last logged event
   CREATE EVENT log_event
ON SCHEDULE EVERY 1 second
STARTS CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 1 minute
DO
   INSERT INTO logtb (message,created_at)
   VALUES('log Event',NOW());

-- drop the event when done
DROP EVENT log_event;
