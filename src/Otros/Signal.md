# SINGAL

Se trata de una forma de lanzar un error. Se puede controlar con `HANDLER`.

SQLSTATE Tiene que ser una cadena de 5 caracteres


## Sintaxis

```sql
SIGNAL error_condition
    [SET error_property [, error_property] ...]

error_condition:
    SQLSTATE [VALUE] 'sqlstate_value'
  | condition_name

error_property:
    error_property_name = <error_property_value>

error_property_name:
    CLASS_ORIGIN
  | SUBCLASS_ORIGIN
  | MESSAGE_TEXT
  | MYSQL_ERRNO
  | CONSTRAINT_CATALOG
  | CONSTRAINT_SCHEMA
  | CONSTRAINT_NAME
  | CATALOG_NAME
  | SCHEMA_NAME
  | TABLE_NAME
  | COLUMN_NAME
  | CURSOR_NAME
```


## Ejeplos

```sql
DELIMITER //
CREATE OR REPLACE TRIGGER trigger_operation_prevent_oversell BEFORE INSERT
ON operation FOR EACH ROW
BEGIN
    SET @quantity = (
        SELECT quantity FROM a_has_t
        WHERE account_id = NEW.account_id and ticker_id = NEW.ticker_id
    );
    IF (@quantity + NEW.quantity < 0) THEN
        SIGNAL SQLSTATE '32132' SET message_text='No tiens suficientes acciones';  
    END IF;
END//
DELIMITER ;
```