require "./lib/math_expansion/matriz.rb"

module MathExpansion
  # Esta clase permite representar matrices densas. Las matrices densas son aquellas que no tienen más de un 60% de elementos nulos.
  # Su representación será muy similar a como se suelen representar tradicionalmente.
  class Matriz_Densa < Matriz
    # Se pasará por parámetros las filas y columnas de la matriz:
    # * *n*: Número de filas.
    # * *m*: Número de columnas.
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
    # * *i*: Número de fila.
    # * *j*: Número de columna.
    def get(i, j)
      if( i < 0 or i >=@N or j < 0 or j >= @M)
        return nil
      end

      @contenido[i][j]
    end
    # Devuelve el porcentaje de valores nulos que hay en la matriz.
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
    # * *i*: Número de fila.
    # * *j*: Número de columna.
    # * *value*: Valor a insertar en la matriz.
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
    # Permite sumar un elemento a una matriz
    def +(other)
      		raise ArgumentError , 'Tipo invalido' unless other.is_a? Matriz
      		raise ArgumentError , 'Matriz no compatible' unless @N == other.N and @M == other.M
  
      		c = Matriz_Densa.new(@N, @M)
      		i = 0
		while(i < @N)
        		j = 0
        		while(j < @M)
	      			c.set(i, j, get(i,j) + other.get(i,j))
    	  			j += 1
    			end 
    			i += 1
      		end
		if (c.null_percent > 0.6)
			c = MathExpansion::Matriz_Dispersa.copy(c)
		end
      		c
    end
    # Permite restar un elemento a una matriz.
    def -(other)
      		raise ArgumentError , 'Tipo invalido' unless other.is_a? Matriz
      		raise ArgumentError , 'Matriz no compatible' unless @N == other.N and @M == other.M
  
      		c = Matriz_Densa.new(@N, @M)
      		i = 0
      		while(i < @N)
        		j = 0
        		while(j < @M)
	      			c.set(i, j, get(i,j) - other.get(i,j))
    	  			j += 1
    			end
    			i += 1
      		end
		if (c.null_percent > 0.6)
			c = MathExpansion::Matriz_Dispersa.copy(c)
		end
      		c
    end
    # Permite multiplicar un elemento a una matriz.
    #--
    def *(other)
    		raise ArgumentError , 'Parametro invalido' unless other.is_a? Numeric or other.is_a? Matriz

    		if(other.is_a? Numeric) # Matriz * numero
      			c = Matriz_Densa.new(@N, @M)
	  		i = 0
      			while(i < @N)
        			j = 0
        			while(j < @M)
         				c.set(i, j, get(i,j)*other)
         				j += 1
	    			end # while j
	    			i += 1
      			end # while i
    		else # Matriz * Matriz
      			raise ArgumentError , 'Matriz no compatible (A.N == B.M)' unless @M == other.N
      			c = Matriz_Densa.new(@N, other.M)
      			i = 0
      			while(i < @N)
        			j = 0
        			while(j < other.M)
	      				k = 0
					#if (get(i,j).is_a? Fraccion)	      				
					#	c.set(i, j, Fraccion.null
					#else
					#	c.set(i, j, 0)
					#end
	      				while(k < @M)
	        				c.set(i, j, get(i, k) * other.get(k,j) + c.get(i,j))
	        				k += 1
	      				end # while k
          				j += 1
        			end # while j
	    			i += 1
      			end # while i
    		end # while else
  		if (c.null_percent > 0.6)
			c = MathExpansion::Matriz_Dispersa.copy(c)
		end
    		c
    end # *(other) #++
    # Devuelve el máximo valor almacenado en la matriz.
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
  end # Class
end # Module #++
