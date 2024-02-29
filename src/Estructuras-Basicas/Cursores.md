# Cursores

Un cursor es una estructura que te permite iterar registros en orden y realizar un procesamiento en función del resultado.


## Definicion de las extructuras

### Declaracion

```sql
DECLARE cursor_name CURSOR [(cursor_formal_parameter[,...])] FOR select_statement

cursor_formal_parameter:
    [IN] name type [collate clause]
```

### Sentencia fetch

```sql
FETCH cursor_name INTO var_name [, var_name] ...
```

### Uso

<div class='warning'>
Si esta forma no te convence mira el ejemplo
</div>

```sql
/*Declarar cursores*/

DECLARE vacio INT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET vacio=TRUE;

OPEN cursor_name;

read_loop: LOOP
    FETCH cursor_name INTO var_name [, var_name] ...

    IF vacio THEN
        LEAVE read_loop;
    END IF;

    /*Usar aqui las variables recogidas en el fetch*/

END LOOP;

CLOSE cursor_name;
```


## Ejemplos

Ejemplo dentro de un procedimiento

```sql
use bd_juego;
CREATE TABLE `plataforma_dia` (
  `id_plataforma` int(10) unsigned NOT NULL,
  `nombre` varchar(128) NOT NULL,
  `fecha` date NOT NULL,
  `dias` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_plataforma`)
);

DELIMITER //

CREATE OR REPLACE PROCEDURE calculadias()
BEGIN
    DECLARE v_fecha DATE;
    DECLARE v_id_plataforma INT UNSIGNED;
    DECLARE v_nombre VARCHAR(128);
    DECLARE v_fecha_old DATE;
    DECLARE sigue BOOLEAN;
    DECLARE cur CURSOR FOR
        SELECT id_plataforma, nombre, fecha
        FROM plataforma
        ORDER BY fecha ASC;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET sigue=FALSE;

    /*Ponemos la variable asociada al handler a true*/
    SET sigue=TRUE;
    
    /*Abrimos cursor, es decir, ejecuta la consulta*/
    OPEN cur;
    
    /*Traete la primera fila*/
    FETCH cur INTO v_id_plataforma, v_nombre, v_fecha;
    SET v_fecha_old=v_fecha;

    WHILE sigue DO
        INSERT INTO plataforma_dia
        VALUES (v_id_plataforma, v_nombre, v_fecha, DATEDIFF(v_fecha, v_fecha_old));
        
        SET v_fecha_old=v_fecha;
        
        /*Como ultima sentencia del while, traete la siguiente fila*/
        FETCH cur INTO v_id_plataforma, v_nombre, v_fecha;
    END WHILE;
    
    /*Cerrar siempre el cursor al final*/
    CLOSE cur;
END //

DELIMITER ;
```