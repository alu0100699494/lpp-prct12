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
	#@contenido guarda los valores no nulos.
	#@indice_contenido guarda la fila del valor no nulo correspondiente a @contenido.
	#@comienzo_columna guarda la posición de comienzo de la columna.
	#@elementos_columna es un vector que contiene el numero de elementos de la columna.
	#@n_nonulo: número de valores no nulos.
	
	def reset
	  @contenido = Array.new(@N) # Array con @N filas y ninguna columna (vacio)
	  i = 0
	  while(i < @N)
	    @contenido[i] = []
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
		    obj.contenido[i] << Elemento.new(j, value)
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
	  if( i < 0 or i >=@N or j < 0 or j >= @M)
	    return nil
	  end
	  
	  k = 0
	  while( k < @contenido[i].size and @contenido[i].size > 0)
	    if(@contenido[i][k].columna == j)
		  return @contenido[i][k].valor
		end
	    k += 1
	  end
	  return 0
	end #endmethod get
	
	def set(i, j, value)
	  if(!(value.class.respond_to? :null))
		puts "Se debe definir el metodo \"null\" que devuelva un elemento nulo para la clase #{value.class}"
		return nil
	  end
	  
	  if( i < 0 or i >=@N or j < 0 or j >= @M or value == value.class.null)
	    puts "Elemento fuera de rango o de valor nulo."
	    return nil
	  end
	  
	  k = 0
	  # COMPROBAR VALORES NULOS!
	  if(@contenido[i].size == 0)
	    @contenido[i].insert(0, Elemento.new(j, value))
      else
  	    while( k < @contenido[i].size and @contenido[i].size > 0 and j > @contenido[i][k].columna)
	      k += 1
	    end
	  
	    # 2 casos:
		if(k == @contenido[i].size) # Ultimo elemento del vector
		  @contenido[i] << Elemento.new(j, value)
		else
	      if(j == @contenido[i][k].columna)    # j == @contenido[i][k].column
	        @contenido[i][k].valor = value
	      elsif(j < @contenido[i][k].columna)  # j  < @contenido[i][k].column
	        @contenido[i].insert(k, Elemento.new(j, value))
	      end
		end
	  end #endif
	  if(null_percent < 0.6) # Si se ha sobrepasado el número de elementos nulos, borramos el último elemento modificado
		  @contenido[i].delete_at(k)
		  puts "Borrado el elemento #{i},#{k} por sobrepasar el número de elementos no nulos (Porcentaje actual: #{null_percent}"
	  end
	  
	end #endmethod set
	
  end #endclass
end #end module
