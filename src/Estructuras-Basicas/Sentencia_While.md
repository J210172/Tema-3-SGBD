# Contador WHILE

El `while` es una sentecia que ejecuta un bloque de codigo siempre que se cumpla una condicion.


El while se escribiria asi:

```sql

/*Contador de 1 al 10*/

DELIMITER //

SET @n=0//

WHILE @n<10 DO
    SET @n=@n+1;
    SELECT @n;
END WHILE//

SELECT 'fin'//

DELIMITER ;

```


Otro ejemplo con el contador inverso:

```sql
/*Cuenta atrás del 10 al 0*/

DELIMITER //

SET @n=11//

WHILE @n>0 DO
    SET @n=@n-1;
    SELECT @n;
END WHILE//

SELECT 'fin'//

DELIMITER ;
```


## Algunos ejercicios:

### Ejercicio 1

50 primeros números pares

```sql

DELIMITER //

SET @i=0//
SET @j=0//

WHILE @j<50 DO
    SET @j=@j+1;
    SET @i=@i+2;
    SELECT @i;
END WHILE//

DELIMITER ;

```


### Ejercicio 2

Múltiplos de 7 menores que 1000

```sql
DELIMITER //

SET @i=7//

WHILE @i<1000 DO
    SELECT @i;
    SET @i=@i+7;
END WHILE//

DELIMITER ;
```


### Ejercicio 3

200 primeros números de Fibonacci

```sql
DELIMITER //

SET @f0=0;
SET @f1=1;
SET @aux=0;
SET @i=0;

SELECT @f0, @f1;

WHILE @i<200 DO
    SET @aux=@f1;
    SET @f1=@f1+@f0;
    SET @f0=@aux;
    SELECT @f0, @f1;
    SET @i=@i+1;
END WHILE//

DELIMITER ;
```