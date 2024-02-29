# Eventos

Los eventos son tareas programadas con nombre que contienen declaraciones SQL que MariaDB ejecutara en una etapa posterior, ya sea una vez o en intervalos regulares.

Por defecto en MariaDB el Event Scheduler viene desactivado.

## Instrucciones activación

### Para activarlo de forma dinámica:

```sql
SET GLOBAL event_scheduler=ON;
```

### Para activarlo de forma permanente:

Añadir la siguiente línea al fichero /etc/mysql/mariadb.conf.d/50-server.cnf, bajo el epígrafe [mysqld]:
```
...
event_scheduler=ON
...
```

A continuación reiniciar el servicio MariaDB.


## Definicion de las extructuras

### Estructura de creacion

```sql
CREATE [OR REPLACE]
    [DEFINER = { user | CURRENT_USER | role | CURRENT_ROLE }]
    EVENT 
    [IF NOT EXISTS]
    event_name    
    ON SCHEDULE schedule
    [ON COMPLETION [NOT] PRESERVE]
    [ENABLE | DISABLE | DISABLE ON SLAVE]
    [COMMENT 'comment']
    DO sql_statement;

schedule:
    AT timestamp [+ INTERVAL interval] ...
  | EVERY interval 
    [STARTS timestamp [+ INTERVAL interval] ...] 
    [ENDS timestamp [+ INTERVAL interval] ...]

interval:
    quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE |
              WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |
              DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}
```

### Estructura de modificación

```sql
ALTER
    [DEFINER = { user | CURRENT_USER }]
    EVENT event_name
    [ON SCHEDULE schedule]
    [ON COMPLETION [NOT] PRESERVE]
    [RENAME TO new_event_name]
    [ENABLE | DISABLE | DISABLE ON SLAVE]
    [COMMENT 'comment']
    [DO sql_statement]
```


### Estructura de eliminación

```sql
DROP EVENT [IF EXISTS] event_name
```


## Ejemplos

```sql
DELIMITER //

CREATE OR REPLACE EVENT insertaEnIbex35
ON SCHEDULE EVERY 1 DAY STARTS '2024-02-08 09:59:00' DO 
BEGIN
    INSERT INTO bolsa.ibex35 (precio, fecha)
    VALUES (40, CURRENT_DATE);
END//

DELIMITER ;
```

```sql
CREATE EVENT example1 
    ON SCHEDULE EVERY 1 MINUTE DO 
        UPDATE test.t1 SET a = a + 1;
```

```sql
CREATE EVENT example2
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 DAY + INTERVAL 3 HOUR
DO some_task;
```

```sql
CREATE EVENT example3
ON SCHEDULE EVERY 1 HOUR
STARTS CURRENT_TIMESTAMP + INTERVAL 1 MONTH
ENDS CURRENT_TIMESTAMP + INTERVAL 1 MONTH + INTERVAL 1 WEEK
DO some_task; 
```

`some_task` se reemplazaria por la accion a realizar

```sql
ALTER EVENT myevent 
    ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 2 HOUR 
    DO 
        UPDATE myschema.mytable SET mycol = mycol + 1;
```