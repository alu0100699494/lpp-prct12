# MathExpansion


Útil gema de Ruby para representar matrices densas y dispersas.

## Instalación

Añada esta línea al fichero Gemfile de su aplicación:

    gem 'math_expansion'

Y a continuación ejecute:

    $ bundle

O instale manualmente:

    $ gem install math_expansion

## Planteamiento

La clase Matriz contendrá el número de filas, número de columnas y un vector de contenido.

La matriz densa se representará como en la práctica anterior.
La matriz dispersa se representará como un Array que contendrá un Hash por cada fila. Cada par clave-valor del hash representará la fila de un elemento no nulo y el valor de ese elemento, respectivamente.

Las operaciones entre matrices se hará de manera natural, operando con las matrices dadas independientemente de que sean densas o dispersas. Dado que en cualquier operación puede cambiar el número de valores nulos de manera impredecible, será en la matriz resultado (en principio densa) donde se hará una comprobación de los valores nulos de la misma, y si éste es superior al 60%, la matriz resultado se convertirá a dispersa; en caso contrario, la matriz resultado seguirá siendo densa.
