require "./lib/math_expansion/matriz.rb"
require "./lib/math_expansion/matriz_densa.rb"

module MathExpansion
  class Matriz_Dispersa < Matriz
    class Elemento
	  def initialize(columna, valor)
	    @columna, @valor = columna, valor
	  end
	end
	#@contenido guarda los valores no nulos.
	#@indice_contenido guarda la fila del valor no nulo correspondiente a @contenido.
	#@comienzo_columna guarda la posición de comienzo de la columna.
	#@elementos_columna es un vector que contiene el número de elementos de la columna.
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
  end #endclass
end #end module
