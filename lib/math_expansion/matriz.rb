require './lib/math_expansion/racional.rb'

module MathExpansion
# Esta clase contendrá el número de filas y columnas de la matriz.
  class Matriz
    # Número de filas.
    attr_reader :N
    # Número de columnas.
    attr_reader :M 
    # Vector que contendrá los datos de la matriz.
    attr_reader :contenido
    
    # Constructor de la matriz. Crea una matriz de tamaño N*M sin contenido, inicializando sólo N y M.
    # * *Argumentos*    :
    #   - +n+: Número de filas. Debe ser mayor que 0.
    #   - +m+: Número de columnas. Debe ser mayor que 0.
    def initialize(n, m)
      raise ArgumentError, 'Indice no valido' unless n.is_a? Fixnum and n > 0 and m.is_a? Fixnum and m > 0
    
      @N, @M = n, m
    end
    
    # Método que permite acceder a un elemento de la matriz. Devuelve _nil_. Redefinido en clases hijas.
    def get(i, j)
      nil
    end
    # Método que permite almacenar un elemento en la matriz. Devuelve _nil_. Redefinido en clases hijas.
    def set(i, j, val)
      nil
    end

  end
end
