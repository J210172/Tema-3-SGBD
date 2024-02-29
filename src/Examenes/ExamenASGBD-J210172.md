# Examen J210172

## Ejercicio 1

Programa un disparador que cada vez que tenga lugar una insercion sobre la tabla `operation`, actualice la cantidad de acciones (quantity) que la cuenta (account) tiene de ese `ticker`.

```sql
DELIMITER //
CREATE OR REPLACE TRIGGER trigger_operation_insert after insert
ON operation FOR EACH ROW
BEGIN
	UPDATE a_has_t SET quantity = quantity + new.quantity 
    	WHERE account_id = NEW.account_id and ticker_id = NEW.ticker_id; 
END //
DELIMITER ;
```


## Ejercicio 2

Programar una funcion que reciba como parametro un id de cuenta (account) y devuelva la suma del numero de acciones que dicha cuenta tiene (tabla a_has_t).

```sql
DELIMITER //
CREATE OR REPLACE FUNCTION numero_de_acciones(id INT UNSIGNED)
RETURNS INT
READS SQL DATA
BEGIN
    RETURN (SELECT SUM(quantity) FROM a_has_t WHERE account_id = id);
END//
DELIMITER ;
```


## Ejercicio 3

Crea una copia de la tabla `operation` con la secuencia:\
    `CREATE TABLE operation_copy LIKE operation`;

A continuación crear un evento que se ejecute una vez a la semana y copie todas las operaciones que sean de hace más de dos semanas a la tabla `operation_copy`.


```sql
DELIMITER //
CREATE OR REPLACE EVENT evento_copia_seguriad_operations
ON SCHEDULE EVERY 1 WEEK DO 
BEGIN
   INSERT operation_copy SELECT * FROM operation where 14 < datediff(NOW(), operation_date);
END//
```


## Ejercicio 4

Programar un disparador sobre la tabla `operation` que impida que una cuenta (account) pueda vender más acciones de un determinado `ticker` que las que posee (a_has_t).

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







