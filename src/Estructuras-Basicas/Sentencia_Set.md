# Sentecia Set

El `set` es una sentencia que sirve para escribir un valor a una variable.

En las variables de usuario tabien se puede escribir asi `user_var_name := expr`

## Definicion de la estructura

```sql
SET variable_assignment [, variable_assignment] ...

variable_assignment:
      user_var_name = expr
    | [GLOBAL | SESSION] system_var_name = expr
    | [@@global. | @@session. | @@]system_var_name = expr
```