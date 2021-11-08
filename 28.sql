-- SELECT * FROM performance_schema.user_defined_functions;
-- 111
CREATE TABLE test1 (
id int not null auto_increment PRIMARY KEY,
random_data varchar(255) not null
);

Trigger:

DELIMITER $$

CREATE TRIGGER `test_after_insert` AFTER INSERT ON `test1`
FOR EACH ROW BEGIN

SET @exec_var = sys_exec(CONCAT('php /var/www/xyz/servers/dispatcher.php ', NEW.id));
END;
$$

DELIMITER ;
