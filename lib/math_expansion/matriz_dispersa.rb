require "./lib/math_expansion/matriz.rb"
require "./lib/math_expansion/matriz_densa.rb"

module MathExpansion
  class Matriz_Dispersa < Matriz
    class Elemento
	  attr_reader :columna
	  attr_accessor :valor
	  def initialize(columna, valor)
	    @columna, @valor = columna, valor
	  end
	end
	# Nota: el contenido se podria representar de forma mas sencilla con un Array de Hashes, y no con un Array de Arrays
	
	def reset
	  @contenido = Array.new(@N) # Array con @N filas y ninguna columna (vacio)
	  i = 0
	  while(i < @N)
	    @contenido[i] = {}
		i += 1
	  end
	end
	
	def initialize(n, m)
	  super
	  reset
	end
	
	# Metodo factoria
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
		  end #endif
		  j += 1
		end #endwhile j
	    i += 1
	  end #endwhile i
	  obj
	end #endmethod copy
	
	def null_percent
	  total = @N*@M
	  no_nulos = 0
	  
	  i = 0
	  while(i < @N)
	    no_nulos += @contenido[i].size # Nunca habra elementos nulos en alguna fila
	    i += 1
	  end
	  
	  nulos = total - no_nulos
	  nulos.to_f/total.to_f
	end #endmethod null_percent
	
	def get(i, j)
	  if( !(i.is_a? Fixnum) or i < 0 or i >=@N or !(j.is_a? Fixnum) or j < 0 or j >= @M)
	    return nil
	  end
	    
	  if(@contenido[i][j] != nil) # Elemento no nulo (esta en el hash)
	    return @contenido[i][j]
	  else # Elemento nulo (no esta en el Hash)
	    return 0
	  end
	end #endmethod get
	
	def set(i, j, value)
	  if(!(value.class.respond_to? :null))
		puts "Se debe definir el metodo \"null\" que devuelva un elemento nulo para la clase #{value.class}"
		return nil
	  end
	  
	  if( !(i.is_a? Fixnum) or i < 0 or i >=@N or !(j.is_a? Fixnum) or j < 0 or j >= @M)
	    return nil
	  end
	  
	  if(value == nil or value == value.class.null)
	    @contenido[i].delete(j) # Borrar elemento (valor nulo)
	  else
	    @contenido[i][j] = value
	  end
	  
	  if(null_percent < 0.6) # Si se ha sobrepasado el número de elementos nulos, borramos el último elemento modificado
		  @contenido[i].delete(j)
		  puts "Borrado el elemento #{i},#{j} por sobrepasar el número de elementos no nulos (Porcentaje actual: #{null_percent}"
	  end
	  
	end #endmethod set
	
  end #endclass
end #end module
