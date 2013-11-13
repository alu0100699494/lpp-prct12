require "./lib/math_expansion/matriz.rb"

module MathExpansion
  class Matriz_Densa < Matriz
    def initialize(n, m)
	  super
	  
	  @contenido = Array.new(@N,0)
	  i = 0
	  while i < @N
	    @contenido[i] = Array.new(@M,0)
		i += 1	
	  end
	end
	  
	def get(i, j)
	  if( i < 0 or i >=@N or j < 0 or j >= @M)
	    return nil
	  end

	  contenido[i][j]
	end
	  
	def set(i, j, value)
	  if( i < 0 or i >=@N or j < 0 or j >= @M)
	   return nil
	  end
		
	  if(!(value.class.respond_to? :null))
		puts "Se debe definir el metodo \"null\" que devuelva un elemento nulo para la clase #{value.class}"
		return nil
	  end

	  # Contar elementos nulos y comprobar si se hace una matriz dispersa
	  # De momento, no dejamos añadir elementos nulos
	  # ¿o si?
	  #if(value != nil and value != value.class.null) # Y se puede comprobar para todos los tipos si es necesario. (con un método zero, por ejemplo)
	    contenido[i][j] = value
	  #end
	end
	
    def to_s
	  s = ""
      i = 0
      while(i < @N)
      	j = 0
      	while(j < @M)
	      s += "#{contenido[i][j].to_s}\t"
	      j += 1
	    end
	    s += "\n"
	    i += 1
      end
	  s
	end
	
  end # Class
end # Module