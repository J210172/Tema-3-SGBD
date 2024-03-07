# Operacions con Fechas 

## Interval

Las unidades de tiempo se pueden utilizar en los siguientes contextos:

- Después de un operador `+` o `-`;
- Con las siguientes funciones de `DATE` o `TIME`:
    - ADDDATE()
    - SUBDATE()
    - DATE_ADD()
    - DATE_SUB()
    - TIMESTAMPADD()
    - TIMESTAMPDIFF()
    - EXTRACT()
- En la cláusula `ON SCHEDULE` de `CREATE EVENT` y `ALTER EVENT`.
- Al definir una partición POR SYSTEM_TIME


### Estructura del Interval

```sql
INTERVAL time_quantity time_unit
```


### Ejemplos

```sql
SELECT '2008-12-31 23:59:59' + INTERVAL 1 SECOND;

+-------------------------------------------+
| '2008-12-31 23:59:59' + INTERVAL 1 SECOND |
+-------------------------------------------+
| 2009-01-01 00:00:00                       |
+-------------------------------------------+
```

```sql
INTERVAL '2:2' YEAR_MONTH
INTERVAL '1:30:30' HOUR_SECOND
INTERVAL '1!30!30' HOUR_SECOND
```


### Tabla de unidades

| Unidad | Descripcion |
| ---- | ------|
| MICROSECOND | Microsegundos |
| SECOND | Segundos |
| MINUTE | Minutos |
| HOUR | Horas |
| DAY | Dias |
| WEEK | Semanas |
| MONTH | Meses |
| QUARTER | Cuartos |
| YEAR | Años |
| SECOND_MICROSECOND | Segundos.Microsegundos |
| MINUTE_MICROSECOND | Minutos.Segundos.Microsegundos |
| MINUTE_SECOND | Minutos.Segundos |
| HOUR_MICROSECOND | Horas.Minutos.Segundos.Microsegundos |
| HOUR_SECOND | Horas.Minutos.Segundos |
| HOUR_MINUTE | Horas.Minutos |
| DAY_MICROSECOND | Dias Horas.Minutos.Segundos.Microsegundos |
| DAY_SECOND | Dias Horas.Minutos.Segundos |
| DAY_MINUTE | Dias Horas.Minutos |
| DAY_HOUR | Dias Horas |
| YEAR_MONTH | Años-Meses |


## Funciones

| Nombre | Descrion |
| ----- | -------- |
| ADDDATE() | Agrega valores de tiempo (intervalos) a un valor de fecha. |
| ADD_MONTHS() | Agrega un número determinado de meses a una fecha determinada. |
| ADDTIME() | Agrega tiempo a un valor de tiempo. |
| CONVERT_TZ() | Convierte de una zona horaria a otra. |
| CURDATE() | Devuelve la fecha actual. |
| CURRENT_DATE<br>CURRENT_DATE() | Sinónimos de ACTUALIZACIÓN(). |
| CURRENT_TIME<br>CURRENT_TIME() | Sinónimos de CURTIME(). |
| CURRENT_TIMESTAMP<br>CURRENT_TIMESTAMP() | Sinónimos de AHORA(). |
| CURTIME() | Devuelve la hora actual. |
| DATE() | Extrae la parte de fecha de una expresión de fecha o fecha y hora. |
| DATE_ADD() | Agrega valores de tiempo (intervalos) a un valor de fecha. |
| DATE_FORMAT() | Formatea la fecha dada como se especifica. |
| DATE_SUB() | Resta un valor de tiempo (intervalo) de una fecha. |
| DATEDIFF() | Devuelve la diferencia entre dos fechas (resta una fecha de la otra). |
| DAY() | Sinónimo de DÍA DEL MES(). |
| DAYNAME() | Devuelve el nombre del día de la semana de una fecha determinada. |
| DAYOFMONTH() | Devuelve el día del mes (0-31) de una fecha determinada. |
| DAYOFWEEK() | Devuelve el índice del día de la semana de una fecha determinada. |
| DAYOFYEAR() | Devuelve el día del año (1-366) de una fecha determinada. |
| EXTRACT() | Extrae una parte de fecha de una fecha determinada. |
| FROM_DAYS() | Devuelve una fecha, basada en el número de días dado desde el inicio del calendario estándar (0000-00-00). |
| FROM_UNIXTIME() | Formatea una marca de tiempo de Unix como una fecha. |
| GET_FORMAT() | Devuelve una cadena con formato de fecha basada en los argumentos de entrada. |
| HOUR() | Extrae la hora de una expresión de fecha y hora determinada. |
| LAST_DAY() | Devuelve el último día del mes a partir de su argumento de fecha. |
| LOCALTIME<br>LOCALTIME() | Sinónimo de AHORA(). |
| LOCALTIMESTAMP<br>LOCALTIMESTAMP() | Sinónimo de AHORA(). |
| MAKEDATE() | Crea una fecha a partir del año y el día del año. |
| MAKETIME() | Crea tiempo a partir de hora, minuto, segundo. |
| MICROSECOND() | Extrae los microsegundos de una expresión de hora o fecha y hora determinada. |
| MINUTE() | Extrae el minuto de una expresión de hora o fecha y hora determinada. |
| MONTH() | Extrae el mes de una fecha determinada. |
| MONTHNAME() | Extrae el nombre del mes de una fecha determinada. |
| NOW() | Devuelve la fecha y hora actuales. |
| PERIOD_ADD() | Agrega un período a un valor de año-mes. |
| PERIOD_DIFF() | Devuelve el número de meses entre períodos. |
| QUARTER() | Devuelve el trimestre de una expresión de fecha determinada. |
| SEC_TO_TIME() | Convierte segundos al formato 'hh:mm:ss'. |
| SECOND() | Devuelve los segundos (0-59) de una expresión de hora o fecha y hora determinada. |
| STR_TO_DATE() | Convierte una cadena en un valor de fecha, fecha y hora, según una cadena de formato determinada. |
| SUBDATE() | Resta una cantidad de una fecha determinada. Sinónimo de DATE_SUB() cuando se invoca con tres argumentos. |
| SUBTIME() | Resta un valor de tiempo de otro valor de tiempo. |
| SYSDATE() | Devuelve la hora a la que se ejecuta la función. |
| TIME() | Extrae la parte de tiempo de la expresión de hora o fecha y hora y la devuelve como una cadena. |
| TIME_FORMAT() | Formatea un valor de tiempo según la cadena de formato dada. |
| TIME_TO_SEC() | Devuelve el argumento de tiempo convertido a segundos. |
| TIMEDIFF() | Devuelve la diferencia entre dos valores de hora o fechahora. Resta el segundo tiempo del primero. |
| TIMESTAMP() | Con un solo argumento, esta función devuelve la expresión de fecha o fecha y hora como un valor de fecha y hora. Con dos argumentos, agrega el argumento de hora al argumento de fecha o fecha y hora y luego devuelve el valor de fecha y hora resultante. |
| TIMESTAMPADD() | Agrega un intervalo a una expresión de fecha y hora. |
| TIMESTAMPDIFF() | Devuelve la diferencia entre dos expresiones de fecha y hora, según una unidad determinada. |
| TO_DAYS() | Devuelve el argumento de fecha convertido a días. |
| TO_SECONDS() | Devuelve el argumento de fecha o fecha y hora convertido a segundos desde el año 0. |
| UNIX_TIMESTAMP() | Devuelve una marca de tiempo de Unix. |
| UTC_DATE() | Devuelve la fecha UTC actual. |
| UTC_TIME() | Devuelve la hora UTC actual. |
| UTC_TIMESTAMP() | Devuelve la fecha y hora UTC actuales. |
| WEEK() | Devuelve el número de semana de una fecha o expresión de fecha y hora determinada. |
| WEEKDAY() | Devuelve el índice del día de la semana a partir de una expresión de fecha o fecha y hora determinada. |
| WEEKOFYEAR() | Devuelve la semana calendario de la fecha (1-53) de una fecha o expresión de fecha y hora determinada. |
| YEAR() | Devuelve el año de una fecha o expresión de fecha y hora determinada. |
| YEARWEEK() | Devuelve el año y la semana de una fecha o expresión de fecha y hora determinada. |