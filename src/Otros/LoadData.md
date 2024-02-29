# Load Data

La sentecia load data sirve para cargar datos de un archivo de texto plano a sql.

## Definicion de la esctructura

```sql
LOAD DATA [LOW_PRIORITY | CONCURRENT] [LOCAL] INFILE 'file_name'
    [REPLACE | IGNORE]
    INTO TABLE tbl_name
    [CHARACTER SET charset_name]
    [{FIELDS | COLUMNS}
        [TERMINATED BY 'string']
        [[OPTIONALLY] ENCLOSED BY 'char']
        [ESCAPED BY 'char']
    ]
    [LINES
        [STARTING BY 'string']
        [TERMINATED BY 'string']
    ]
    [IGNORE number {LINES|ROWS}]
    [(col_name_or_user_var,...)]
    [SET col_name = expr,...]
```

## Ejemplos

Ejemplo 1

El archivo: `/tmp/data1.csv`
```csv
nobme,nota
pepe,2
manolo,8
pernado,6
julia,6.5
ming xing,9
```

```sql
CREATE TABLE alumnos (nombre VARCHAR(100), nota int, PRIMARY KEY (nombre));

LOAD DATA LOCAL INFILE '/tmp/data1.csv'
    INTO TABLE alumnos
    FIELDS TERMINATED BY ','
    IGNORE 1 LINES
    (nombre, nota)
    

SELECT * FROM tabla1;
+------+------+------+
| a    | b    | c    |
+------+------+------+
|    2 |    2 |    4 |
|    3 |    3 |    6 |
|    4 |    4 |    8 |
|    5 |    5 |   10 |
|    6 |    8 |   14 |
+------+------+------+
```

\
Ejemplo 2

El archivo: `/tmp/data2.csv`

```csv
2,2
3,3
4,4
5,5
6,8
```

```sql
CREATE TABLE tabla1 (a int, b int, c int, d int, PRIMARY KEY (a));

LOAD DATA LOCAL INFILE '/tmp/data2.csv'
    INTO TABLE tabla1
    FIELDS TERMINATED BY ','
    (a, b)
    SET c=a+b;

SELECT * FROM tabla1;
+------+------+------+
| a    | b    | c    |
+------+------+------+
|    2 |    2 |    4 |
|    3 |    3 |    6 |
|    4 |    4 |    8 |
|    5 |    5 |   10 |
|    6 |    8 |   14 |
+------+------+------+
```

\
Ejemplo 2

El archivo: `/tmp/data3.csv`

```csv
1       a
2       b
```

```sql
LOAD DATA INFILE 'data3.txt'
    INTO TABLE tabla2
    (@i,v)
    SET i=@i*2;

SELECT * FROM tabla2;
+------+------+
| i    | v    |
+------+------+
|    2 | a    |
|    4 | b    |
+------+------+
```