# Procedimientos

Los procedimientos son estructuras que sirven para reusar bloque de codigo, a las cuales se le pueden pasar argumentos.

Tienen tres modalidades de parámetros:

- IN de entrada: Da error si pretendes escribir en él desde el cuerpo del procedimiento
    
- OUT de salida: Da error si pretendes leer de él desde el cuerpo del procedimiento

- INOUT de entrada-salida: Puedes escribir o leer en él desde el cuerpo del procedimiento sin problema


Puedes pasarles un valor con un argumento con el modo 'IN' o 'INOUT'.

Tambien son capaces de "devolver" un resultado a partir de escribir en un argumento con el modo 'OUT' o 'INOUT'.

Los procedimientos se invocan con la sentencia `CALL`


## Definicion de la estructura de creación

```sql
CREATE
    [OR REPLACE]
    [DEFINER = { user | CURRENT_USER | role | CURRENT_ROLE }]
    PROCEDURE [IF NOT EXISTS] sp_name ([proc_parameter[,...]])
    [characteristic ...] routine_body

proc_parameter:
    [ IN | OUT | INOUT ] param_name type

type:
    Any valid MariaDB data type

characteristic:
    LANGUAGE SQL
  | [NOT] DETERMINISTIC
  | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
  | SQL SECURITY { DEFINER | INVOKER }
  | COMMENT 'string'

routine_body:
    Valid SQL procedure statement
```

## Ejemplos

Procedimiento que calcula el área del círculo a partir del radio

```sql

delimiter //

CREATE PROCEDURE p_areacirculo(IN radio DOUBLE, OUT area DOUBLE)
BEGIN
    SET area=radio*radio*pi();
END//

delimiter ;

```

### Uso del procedimiento

Cómo se utiliza el procedimiento


```sql
SET @r=2;
SET @a=NULL;
CALL p_areacirculo(@r, @a); /**/
SELECT @a; /*12.566370614359172*/
```


## Ejercicios

Procedimiento que calcula la cantida de empleados con el mismo genero.

```sql

DELIMITER //

CREATE OR REPLACE PROCEDURE contar_genero(IN gend VARCHAR(50), OUT total INT UNSIGNED)
BEGIN
  SET total = (
    SELECT COUNT(*) 
    FROM employees 
    WHERE gender = gend);
END
//

DELIMITER ;

```



