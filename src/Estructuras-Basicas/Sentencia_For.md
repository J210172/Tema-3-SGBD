# Sentecia For


El `for` es una sentecia que permite ejecutar un bloque de codigo de acuerdo por cada iteracion. 

## Definicion de la estructura

```sql
[begin_label:]
FOR var_name IN [ REVERSE ] lower_bound .. upper_bound
    DO statement_list
END FOR [ end_label ]
```

```sql
[begin_label:]
FOR record_name IN cursor_name [ ( cursor_actual_parameter_list)]
    DO statement_list
END FOR [ end_label ]
```

```sql
[begin_label:]
FOR record_name IN ( select_statement )
    DO statement_list
END FOR [ end_label ]
```

## Ejemplos

```sql
CREATE TABLE t1 (a INT);

DELIMITER //

FOR i IN 1..3
DO
  INSERT INTO t1 VALUES (i);
END FOR;
//

DELIMITER ;

SELECT * FROM t1;
+------+
| a    |
+------+
|    1 |
|    2 |
|    3 |
+------+
```


```sql
CREATE OR REPLACE TABLE t1 (a INT);

DELIMITER //
FOR i IN REVERSE 4..12
DO
    INSERT INTO t1 VALUES (i);
END FOR;
//
Query OK, 9 rows affected (0.422 sec)


DELIMITER ;

SELECT * FROM t1;
+------+
| a    |
+------+
|   12 |
|   11 |
|   10 |
|    9 |
|    8 |
|    7 |
|    6 |
|    5 |
|    4 |
+------+
```