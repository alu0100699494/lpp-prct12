require "./lib/math_expansion/matriz.rb"
require "./lib/math_expansion/matriz_densa.rb"

module MathExpansion
  # Esta clase permite representar matrices dispersas. Estas matrices tendrán un 60% o más de valores nulos.
  # La representación se hará por filas que no tengan elementos nulos, indicando para cada una de ellas qué elementos son no nulos.
  class Matriz_Dispersa < Matriz  
    # Rellena el array de contenido de la matriz con hashes vacíos. Equivale a una matriz con un 100% de elementos nulos.
    def reset
      @contenido = Array.new(@N) #-- # Array con @N filas y ninguna columna (vacio) #++
      i = 0
      while(i < @N)
        @contenido[i] = {}
        i += 1
      end
    end
    # Constructor de la matriz. Crea una matriz dispersa de tamaño N*M vacía (Array de hashes vacíos).
    # * *Argumentos*    :
    #   - +n+: Número de filas. Debe ser mayor que 0.
    #   - +m+: Número de columnas. Debe ser mayor que 0.
    def initialize(n, m)
      super
      reset
    end
    
    # Se devuelve una matriz dispersa a partir de otra matriz pasada por parámetro con los mismos valores. Metodo factoria. 
    # * *Argumentos*    :
    #   - +matriz+: Matriz densa. Si sólo tiene valores nulos, la matriz actual se inicializará a vacío.
    # * *Devuelve*    :
    #   - +obj+: Referencia al objeto creado.
    def self.copy(matriz)
      raise ArgumentError, 'Tipo invalido' unless matriz.is_a? MathExpansion::Matriz_Densa
      obj = new(matriz.N, matriz.M)
    
      i = 0
      while(i < matriz.N)
        j = 0
        while(j < matriz.M)
          value = matriz.get(i,j)
          raise RuntimeError , "No se ha definido \"null\" para la clase #{value.class}" unless value.class.respond_to? :null
          
          if( value != value.class.null)
            obj.contenido[i][j] = value
          end #-- #endif 
          j += 1
        end #endwhile j
        i += 1
      end #endwhile i
      obj
    end #endmethod copy #++
    
    # Devuelve el porcentaje de elementos nulos que tiene la matriz.
    # * *Devuelve*    :
    #   - Número flotante entre 0 y 1 que represente cuantos valores nulos existen en la matriz densa.
    def null_percent
      total = @N*@M
      no_nulos = 0
      
      i = 0
      while(i < @N)
        no_nulos += @contenido[i].size #-- # Nunca habra elementos nulos en alguna fila #++
        i += 1
      end
      
      nulos = total - no_nulos
      nulos.to_f/total.to_f
    end #-- #endmethod null_percent #++
    # Permite obtener el elemento en la posición (i,j), donde:
    # * *Argumentos*    :
    #   - +i+: Número de fila.
    #   - +j+: Número de columna.
    # * *Devuelve*    :
    #   - Valor almacenado en la fila +i+ y en la columna +j+. Devuelve nil si +i+ o +j+ están fuera de rango. Devuelve 0 (valor nulo) si no existe el elemento en la matriz.
    def get(i, j)
      if( !(i.is_a? Fixnum) or i < 0 or i >=@N or !(j.is_a? Fixnum) or j < 0 or j >= @M)
        return nil
      end
        
      if(@contenido[i][j] != nil) #-- # Elemento no nulo (esta en el hash)
        return @contenido[i][j]
      else # Elemento nulo (no esta en el Hash)
        return 0
      end
    end #endmethod get #++
    # Establece el valor _value_ en la posición (i,j) de la matriz, donde:
    # * *Argumentos*    :
    #   - +i+: Número de fila.
    #   - +j+: Número de columna.
    #   - +value+: Valor a insertar en la matriz. Si se sobrepasa el número de valores nulos permitidos, no se harán modificaciones en la matriz.
    def set(i, j, value)
      if(!(value.class.respond_to? :null))
        puts "Se debe definir el metodo \"null\" que devuelva un elemento nulo para la clase #{value.class}"
        return nil
      end
      
      if( !(i.is_a? Fixnum) or i < 0 or i >=@N or !(j.is_a? Fixnum) or j < 0 or j >= @M)
        return nil
      end
      
      if(value == nil or value == value.class.null)
        @contenido[i].delete(j)  #-- # Borrar elemento (valor nulo) #++
      else
        @contenido[i][j] = value
      end
      
      if(null_percent < 0.6) #-- # Si se ha sobrepasado el número de elementos nulos, borramos el último elemento modificado #++
          @contenido[i].delete(j)
          puts "Borrado el elemento #{i},#{j} por sobrepasar el numero de elementos no nulos (Porcentaje actual: #{null_percent}"
      end
      
    end #-- #endmethod set #++
    # Permite representar de manera gráfica la matriz por consola.
    # * *Devuelve*    :
    #   - Objeto del tipo string con todos los elementos de la matriz.
    def to_s
      #--
      # Ejemplo: "Fila 0: \nFila 1: 0=>1 1=>3 \nFila 2: \n"
      # 0 0
      # 1 3
      # 0 0
      #++
      i = 0
      output = ""
      while(i < @N)
        output += "Fila #{i}: "
        @contenido[i].sort.each{|k, v| output += "#{k.to_s}=>#{v.to_s} "}
        output += "\n"
        i += 1
      end
      output
    end
    
    # Devuelve el máximo valor no nulo almacenado en la matriz.
    # * *Devuelve*    :
    #   - Valor máximo no nulo almacenado en la matriz.
	def max
	  if(null_percent == 1.0)
	    return nil  #-- # o return 0 #++
	  end
	  #--
	  # Valor máximo: si todos los elementos son menores que el elemento nulo
	  # Se devolverá el mayor elemento no nulo.
	  max = nil
	  
	  # Asignar al primer valor no-nulo de la matriz
	  i = 0
	  while(max == nil)
	    if(@contenido[i].size != 0)
		  max = @contenido[i].values[0]
		end
		i += 1
	  end
	  
	  # Iterar por todos los elementos no nulos para encontrar el maximo
	  i = 0
	  while(i < @contenido.size)
	    if(@contenido[i].values.max != nil and @contenido[i].values.max > max)
		  max = @contenido[i].values.max
		end
	    i += 1
	  end
	  
	  max
	end #++
    # Devuelve el mínimo valor no nulo almacenado en la matriz.
    # * *Devuelve*    :
    #   - Valor mínimo no nulo almacenado en la matriz.
	def min
	  if(null_percent == 1.0)
	    return nil #-- # o return 0 #++
	  end
	  # --
	  # Valor máximo: si todos los elementos son menores que el elemento nulo
	  # Se devolverá el mayor elemento no nulo.
	  min = nil
	  
	  # Asignar al primer valor no-nulo de la matriz
	  i = 0
	  while(min == nil)
	    if(@contenido[i].size != 0)
		  min = @contenido[i].values[0]
		end
		i += 1
	  end
	  
	  # Iterar por todos los elementos no nulos para encontrar el maximo
	  i = 0
	  while(i < @contenido.size)
	    if(@contenido[i].values.min != nil and @contenido[i].values.min < min)
		  min = @contenido[i].values.min
		end
	    i += 1
	  end
	  
	  min
    end 
    
  end #endclass
end #end module #++
