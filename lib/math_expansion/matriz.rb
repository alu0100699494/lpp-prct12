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
    
    # Los parámetros corresponden con el número de filas y columnas de la matriz:
    # * *n*: Número de filas.
    # * *m*: Número de columnas.
    def initialize(n, m)
      raise ArgumentError, 'Indice no valido' unless n.is_a? Fixnum and n > 0 and m.is_a? Fixnum and m > 0
    
      @N, @M = n, m
    end

  end
end
