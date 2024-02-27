# Contador WHILE

El while es una sentecia que ejecuta un bloque de codigo siempre que se cumpla una condicion.


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