# Funciones

Las funciones son estructuras que sirven para reusar bloque de codigo, a las cuales se le pueden pasar argumentos, y pueden devolver algo.

Se invocan de usando `SELECT`

```sql
SELECT Mi_Funcion();
```


## Definicion de las extructuras

### Estructura de creacion

```sql
CREATE [OR REPLACE]
    [DEFINER = {user | CURRENT_USER | role | CURRENT_ROLE }]
    [AGGREGATE] FUNCTION [IF NOT EXISTS] func_name ([func_parameter[,...]])
    RETURNS type
    [characteristic ...]
    RETURN func_body


func_parameter:
    [ IN | OUT | INOUT | IN OUT ]  param_name type


type:
    Any valid MariaDB data type


characteristic:
    LANGUAGE SQL
  | [NOT] DETERMINISTIC
  | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
  | SQL SECURITY { DEFINER | INVOKER }
  | COMMENT 'string'


func_body:
    Valid SQL procedure statement
```

### Estructura de modificación

```sql
ALTER FUNCTION func_name [characteristic ...]

characteristic:
    { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
  | SQL SECURITY { DEFINER | INVOKER }
  | COMMENT 'string'
```

### Estructura de eliminación

```sql
DROP FUNCTION [IF EXISTS] function_name
```


## Ejemplos

```sql
DELIMITER //

CREATE FUNCTION areacirculo(radio DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    RETURN pi() * radio * radio;
END//

DELIMITER ;
```


## Ejercicios

Crear funcion area rectángulo `area = base * altura`.

```sql
DELIMITER //

CREATE FUNCTION arearectangulo(base DOUBLE, altura DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    RETURN base*altura;
END//

DELIMITER ;
```

\
Devuelve true si el número que se le pasa por parámetro es primo y false en caso contrario.

```sql
DELIMITER //

CREATE OR REPLACE FUNCTION esprimo(n INT UNSIGNED)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
   DECLARE i INT UNSIGNED;
   SET i=n-1;
   WHILE i>1 DO
       IF n%i=0 THEN
           RETURN FALSE;
       END IF;
       SET i=i-1;
   END WHILE;
   RETURN TRUE;
END//

DELIMITER ;
```

\
Función que calcula la letra que corresponde al DNI que se le pasa por 
parámetro

```sql
DELIMITER //

CREATE FUNCTION letraDNI(dni INT UNSIGNED)
RETURNS char(1)
    DETERMINISTIC
BEGIN
    DECLARE letras CHAR(23);
    SET letras='TRWAGMYFPDXBNJZSQVHLCKE';
    RETURN substring(letras, 1+(dni%23), 1);
END//

DELIMITER ;
```

\
Comprobar que la letra que ha llegado al final del dni coincide con la letra calculada con la funcion anterior

```sql
DELIMITER //

CREATE OR REPLACE FUNCTION verificaDNI(dni VARCHAR(9))
RETURNS BOOLEAN
BEGIN
    IF letraDNI(substring(dni, 1, length(dni)-1))=substring(dni, length(dni), 1) THEN
        RETURN TRUE;  
    END IF;
    RETURN FALSE;
END//

DELIMITER ;
```


