# Sentencia IF

El if es una sentencia que permite ejecutar una bloque de codigo solo si se cumple su condicion

La sentencia if se escribe asi:

```sql
delimiter //

SET @f='2025-01-01';

IF @f<'2023-09-19' THEN
   SELECT 'es antes del curso';
ELSEIF @f>='2023-09-19' AND @f<='2024-06-21' THEN
   SELECT 'es durante el curso';
ELSEIF @f>'2024-06-21' THEN
   SELECT 'es después del curso';
ELSE
   SELECT 'no lo sé';
END IF

//

delimiter ;

```

Otro ejemplo:

```sql
delimiter //

SET @h='20:20:00';

IF @h='15:30:00' OR @h='16:20:00' OR @h='17:15:00' OR @h='18:10:00' OR @h='19:05:00' OR @h='19:30:00' OR @h='20:20:00' OR @h='21:15:00' THEN
   SELECT 'RRRIIINGGG';
END IF//

delimiter ;
```