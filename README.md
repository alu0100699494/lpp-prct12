# MathExpansion

Útil gema de Ruby para representar matrices densas y dispersas.

## Instalación

Añada esta línea al fichero Gemfile de su aplicación:

    gem 'math_expansion'

Y a continuación ejecute:

    $ bundle

O instale manualmente:

    $ gem install math_expansion

## Uso

TODO: Write usage instructions here

## Planteamiento

La clase Matriz contendrá el número de filas, número de columnas y un vector de contenido.

La matriz densa se representará como en la práctica anterior.
La matriz dispersa se representará como un Array que contendrá un Hash por cada fila. Cada par clave-valor del hash representará la fila de un elemento no nulo y el valor de ese elemento, respectivamente.

Las operaciones entre matrices de cualquier tipo se acabarán realizando como una operación entre matrices densas. Dependiendo del porcentaje de valores nulos, se devolverá la matriz densa resultado o una matriz dispersa creada a partir de esta matriz densa resultado.
Por tanto, sólo se podrán realizar operaciones del tipo:

  - Densa = Densa (op) Densa
  - Densa = Densa (op) Dispersa
