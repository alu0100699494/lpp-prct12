require "./lib/math_expansion/matriz.rb"
require "./lib/math_expansion/matriz_dispersa.rb"
require "./lib/math_expansion/matriz_densa.rb"

module MathExpansion
  class Matriz  
    # Permite sumar matrices (dispersas o densas) de iguales dimensiones.
    # * *Argumentos*    :
    #   - +other+: Matriz densa o dispersa. Debe ser de igual tamaño que la actual.
    # * *Devuelve*    :
    #   - Matriz de tamaño N*M resultado de la suma de la matriz actual con +other+. Si el porcentaje de valores nulos es mayor al 60%, se devuelve una matriz dispersa. Si no, se devuelve una matriz densa.
    def +(other)
      raise ArgumentError , 'Tipo invalido' unless other.is_a? Matriz
      raise ArgumentError , 'Matriz no compatible' unless @N == other.N and @M == other.M
      c = Matriz_Densa.new(@N, @M)
      
      #(0...@N).each do |i|
        #(0...@M).each do |j|
      (@N).times do |i|
        (@M).times do |j|
          c.set(i, j, get(i,j) + other.get(i,j))
        end
      end
      
      #if (c.null_percent > 0.6)
      #  return MathExpansion::Matriz_Dispersa.copy(c)
      #else
      #  return c
      #end 
    end # +(other) #++
    
    # Permite restar matrices (dispersas o densas) de iguales dimensiones.
    # * *Argumentos*    :
    #   - +other+: Matriz densa o dispersa. Debe ser de igual tamaño que la actual.
    # * *Devuelve*    :
    #   - Matriz de tamaño N*M resultado de la resta de la matriz actual con +other+. Si el porcentaje de valores nulos es mayor al 60%, se devuelve una matriz dispersa. Si no, se devuelve una matriz densa.
    def -(other)
      raise ArgumentError , 'Tipo invalido' unless other.is_a? Matriz
      raise ArgumentError , 'Matriz no compatible' unless @N == other.N and @M == other.M
      c = Matriz_Densa.new(@N, @M)
      
      (@N).times do |i|
        (@M).times do |j|
          c.set(i, j, get(i,j) - other.get(i,j))
        end
      end
      
      #if (c.null_percent > 0.6)
      #  return MathExpansion::Matriz_Dispersa.copy(c)
      #else
      #  return c
      #end 
    end # -(other) #++
    
    # Permite multiplicar un elemento a una matriz.
    def *(other)
      raise ArgumentError , 'Parametro invalido' unless other.is_a? Numeric or other.is_a? Matriz

      if(other.is_a? Numeric) # Matriz * numero
        c = Matriz_Densa.new(@N, @M)
        
        (@N).times do |i|
          (@M).times do |j|
            c.set(i, j, get(i,j)*other)
          end
        end
      else # Matriz * Matriz
        raise ArgumentError , 'Matriz no compatible (A.N == B.M)' unless @M == other.N
        c = Matriz_Densa.new(@N, other.M)
        
        (@N).times do |i|
          (other.M).times do |j|
            buffer = (0...@M).inject(0) { |acc, k| get(i, k) * other.get(k,j) + acc }
            c.set(i, j, buffer)
            #(@M).times do |k|
              # Esto NO es programación funcional...
              # c.set(i, j, get(i, k) * other.get(k,j) + c.get(i,j))
            #end
          end
        end
      end

      #if (c.null_percent > 0.6)
      #  return MathExpansion::Matriz_Dispersa.copy(c)
      #else
      #  return c
      #end
    end # *(other) #++
    
  end
end