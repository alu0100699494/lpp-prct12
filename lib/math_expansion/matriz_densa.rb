require "./lib/math_expansion/matriz.rb"

module MathExpansion
  # Esta clase permite representar matrices densas. Las matrices densas son aquellas que no tienen más de un 60% de elementos nulos.
  # Su representación será muy similar a como se suelen representar tradicionalmente.
  class Matriz_Densa < Matriz
    # Constructor de la matriz. Crea una matriz de tamaño N*M inicializada a valores nulos.
    # * *Argumentos*    :
    #   - +n+: Número de filas. Debe ser mayor que 0.
    #   - +m+: Número de columnas. Debe ser mayor que 0.
    def initialize(n, m)
      super
      
      @contenido = Array.new(@N,0)
      i = 0
      while i < @N
        @contenido[i] = Array.new(@M,0)
        i += 1  
      end
    end
    # Permite obtener el elemento en la posición (i,j), donde:
    # * *Argumentos*    :
    #   - +i+: Número de fila.
    #   - +j+: Número de columna.
    #   - +value+: Valor a insertar en la matriz.
    # * *Devuelve*    :
    #   - Valor almacenado en la fila +i+ y en la columna +j+. Devuelve nil si +i+ o +j+ están fuera de rango.
    def get(i, j)
      if( i < 0 or i >=@N or j < 0 or j >= @M)
        return nil
      end

      @contenido[i][j]
    end
    # Devuelve el porcentaje de valores nulos que hay en la matriz.
    # * *Devuelve*    :
    #   - Número flotante entre 0 y 1 que represente cuantos valores nulos existen en la matriz densa.
   def null_percent
      total = @N*@M
      no_nulos = 0
      
      i = 0
      while(i < @N)
        j = 0
        while(j < @M)
          if(@contenido[i][j] != @contenido[i][j].class.null)
            no_nulos += 1
	  end
          j += 1
        end
        i += 1
      end
      
      nulos = total - no_nulos
      nulos.to_f/total.to_f
    end #-- #endmethod null_percent  #++

    # Establece el valor _value_ en la posición (i,j) de la matriz, donde:
    # * *Argumentos*    :
    #   - +i+: Número de fila.
    #   - +j+: Número de columna.
    #   - +value+: Valor a insertar en la matriz.
    
    def set(i, j, value)
      if( i < 0 or i >=@N or j < 0 or j >= @M)
       return nil
      end
        
      if(!(value.class.respond_to? :null))
        puts "Se debe definir el metodo \"null\" que devuelva un elemento nulo para la clase #{value.class}"
        return nil
      end
      #--
      # Contar elementos nulos y comprobar si se hace una matriz dispersa
      # De momento, no dejamos añadir elementos nulos
      # ¿o si?
      #if(value != nil and value != value.class.null) # Y se puede comprobar para todos los tipos si es necesario. (con un método zero, por ejemplo)
        @contenido[i][j] = value
      #end 
      #++
    end
    # Permite representar de manera gráfica la matriz por consola.
    # * *Devuelve*    :
    #   - Objeto del tipo string con todos los elementos de la matriz.
    def to_s
      s = ""
      i = 0
      while(i < @N)
        j = 0
        while(j < @M)
          s += "#{@contenido[i][j].to_s}\t"
          j += 1
        end
        s += "\n"
        i += 1
      end
      s
    end
    
    # Devuelve el máximo valor almacenado en la matriz.
    # * *Devuelve*    :
    #   - Valor máximo almacenado en la matriz.
    def max
	m = get(0,0)
        i = 0
	while(i < @N)
		j = 0
		while(j < @M)
			if (get(i,j) > m)
				m = get(i,j)
			end
			j += 1
		end
		i += 1
	end
	m
    end
    
    # Devuelve el mínimo valor almacenado en la matriz.
    # * *Devuelve*    :
    #   - Valor mínimo almacenado en la matriz.
    def min
	m = get(0,0)
        i = 0
	while(i < @N)
		j = 0
		while(j < @M)
			if (get(i,j) < m)
				m = get(i,j)
			end
			j += 1
		end
		i += 1
	end
	m
    end #-- # Method min
    
    # Devuelve el mínimo valor almacenado en la matriz.
    # * *Argumentos*    :
    #   - Array bidimensional (clase Array).
    # * *Devuelve*    :
    #   - Matriz densa copiada de ese array.
    def self.leerArray(array)
      raise ArgumentError , 'Tipo invalido' unless array.is_a? Array
      
      c = Matriz_Densa.new(array.size(), array[0].size())
      array.each_index do |i|
        array[i].each_index do |j|
          c.set(i, j, array[i][j])
        end
      end
      c
    end #-- # Method leerArray
  end # Class
end # Module #++
