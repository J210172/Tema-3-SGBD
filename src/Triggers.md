# Trigger o Disparador

Un trigger es un fragmento de código que se ejecuta cuando tiene lugar una sentencia DML (insert, update, delete) sobre una tabla.

MariaDB (y MySQL) únicamente soportan triggers a nivel de fila, es decir, se ejecutan una vez por cada fila afectada.

Otros SGBD soportan triggers a nivel de sentencia. Estos sólo se ejecutan una vez, independientemente del número de filas afectadas.

Ejemplo de creacion:

```sql
DELIMITER //

CREATE TRIGGER
nombre_trigger momento evento ON nombre_tabla FOR EACH ROW
BEGIN
/*Código a ejecutar*/
END//

DELIMITER;
```

Donde `momento` puede tomar los valores BEFORE o AFTER.
Y `evento` puede tomar los valores INSERT, UPDATE o DELETE.

Dentro de un trigger el programador puede referirse a las columnas del registro que se está procesando en ese momento mediante las palabras clave NEW o OLD. Según el tipo de trigger puede no estar disponible alguno de ellos, como puede verse en la siguiente tabla.


| EVENTO | NEW           | OLD           |
| ------ | ------------- | ------------- |
| INSERT | Disponible    | No disponible |
| UPDATE | Disponible    | Disponible    |
| DELETE | No disponible | Disponible    |

OLD siempre es de sólo lectura, es decir, NUNCA está permitido ejecutar una sentencia como la siguiente:

```sql
SET OLD.columna1= 78; /*Esta sentencia fallará siempre*/
```

En un trigger de tipo BEFORE sí se puede modificar el registro que va a ser insertado ejecutando una sentencia de este estilo:

```sql
SET NEW.columna1= 39;
```

Tabla resumen de esto:

| Tipo de trigger | OLD          | NEW               |
| --------------- | ------------ | ----------------- |
| BEFORE          | Sólo lectura | Lectura/escritura |
| AFTER           | Sólo lectura | Sólo lectura      |


## Definicion de las extructuras

### Estructura de creacion

```sql
CREATE [OR REPLACE]
    [DEFINER = { user | CURRENT_USER | role | CURRENT_ROLE }]
    TRIGGER [IF NOT EXISTS] trigger_name trigger_time trigger_event
    ON tbl_name FOR EACH ROW
   [{ FOLLOWS | PRECEDES } other_trigger_name ]
   trigger_stmt;
```

### Estructura de eliminación

```sql
DROP TRIGGER [IF EXISTS] [schema_name.]trigger_name
```

## Ejemplos

### Ejemplo 1

Tras un insert en la tabla `animals`, actualiza el valor de la primera columna de la tabla `animal_count` sumandole 1, salvo que el animal sea un Alce (`Moose`), que entonces se le sumara 100.

```sql
DROP TABLE animals;

UPDATE animal_count SET animals=0;

CREATE TABLE animals (id mediumint(9) NOT NULL AUTO_INCREMENT, 
name char(30) NOT NULL, 
PRIMARY KEY (`id`)) 
ENGINE=InnoDB;

DELIMITER //
CREATE TRIGGER the_mooses_are_loose
AFTER INSERT ON animals
FOR EACH ROW
BEGIN
 IF NEW.name = 'Moose' THEN
  UPDATE animal_count SET animal_count.animals = animal_count.animals+100;
 ELSE 
  UPDATE animal_count SET animal_count.animals = animal_count.animals+1;
 END IF;
END; //

DELIMITER ;

INSERT INTO animals (name) VALUES('Aardvark');

SELECT * FROM animal_count;
+---------+
| animals |
+---------+
|       1 |
+---------+

INSERT INTO animals (name) VALUES('Moose');

SELECT * FROM animal_count;
+---------+
| animals |
+---------+
|     101 |
+---------+
```

### Ejemplo 2

Trigger que suma una unidad a la tabla recuentoplataformas cuando se inserta una fila en la tabla
plataforma.

```sql
DELIMITER //

CREATE TRIGGER sumaplataforma AFTER INSERT ON plataforma
FOR EACH ROW
BEGIN
    UPDATE recuentoplataformas SET recuento=recuento+1;
END //

DELIMITER ;
```

Hacer lo mismo pero con la sentencia delete.

Después del delete, se reste 1 al recuento

```sql
DELIMITER //

CREATE TRIGGER restaplataforma AFTER DELETE ON plataforma
FOR EACH ROW
BEGIN
    UPDATE recuentoplataformas SET recuento=recuento-1;
END //

DELIMITER ;
```

### Ejemplo 3

Trigger que hace que toda inserción en tabla ibex35 tenga precio 0.

```sql
DELIMITER //

CREATE TRIGGER precioSiempreCero BEFORE INSERT ON ibex35
FOR EACH ROW
BEGIN
    SET NEW.precio=0.0;
END//

DELIMITER ;
```

### Ejemplo 4

Trigger que añade letra al NIF en caso de que se inserte in ella.

```sql
CREATE TABLE cliente (
    NIF VARCHAR(10) NOT NULL,
    nombre VARCHAR(128) NOT NULL
);

DELIMITER //

CREATE TRIGGER ponLetraNIF BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
    DECLARE c CHAR(1);
    SET c=substring(NEW.nif, length(NEW.nif), 1);
    IF ascii(c)>=48 AND ascii(c)<=57 THEN
        /*ultimo caracter es un numero*/
        SET NEW.nif=CONCAT(NEW.nif, letraDNI(NEW.nif));
    END IF;
END//

DELIMITER ;
```

## Ejercicio

Construir tres disparadores sobre la tabla cliente que anoten en la tabla auditoria_cliente el usuario, instante, operación que se realizó (INSERT, UPDATE o DELETE) y NIF del cliente afectado.

Pista: usar CURRENT_TIMESTAMP y CURRENT_USER

```sql
CREATE TABLE auditoria_cliente (
    usuario VARCHAR(128),
    cuando DATETIME,
    operacion VARCHAR(16),
    NIF VARCHAR(10)
);

CREATE TABLE cliente (
    NIF VARCHAR(10) NOT NULL,
    nombre VARCHAR(128) NOT NULL
);
```

1. Primero decidirse por BEFORE o AFTER.
2. A continuación, programar los tres triggers

SOLUCIÓN:

```sql
DELIMITER //
CREATE OR REPLACE TRIGGER auditoriaClienteInsert AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
     INSERT INTO auditoria_cliente (usuario, cuando, operacion, nif)
     VALUES
     (CURRENT_USER, NOW(), 'INSERT', NEW.nif);
END//
CREATE OR REPLACE TRIGGER auditoriaClienteInsert AFTER UPDATE ON cliente
FOR EACH ROW
BEGIN
     INSERT INTO auditoria_cliente (usuario, cuando, operacion, nif)
     VALUES
     (CURRENT_USER, NOW(), 'UPDATE', NEW.nif);
END//
CREATE OR REPLACE TRIGGER auditoriaClienteInsert AFTER DELETE ON cliente
FOR EACH ROW
BEGIN
     INSERT INTO auditoria_cliente (usuario, cuando, operacion, nif)
     VALUES
     (CURRENT_USER, NOW(), 'DELETE', OLD.nif);
END//
DELIMITER ;
```
