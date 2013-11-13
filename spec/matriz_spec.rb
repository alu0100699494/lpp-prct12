require "./lib/math_expansion.rb"

describe MathExpansion::Matriz do
	before :each do
		@m1 = MathExpansion::Matriz.new(5, 5)
	end
	describe " # Almacenamiento de matrices. " do
		it " # Se debe almacenar el numero de filas." do
			@m1.N
		end
		it " # Se debe almacenar el numero de columnas." do
			@m1.M
		end
		it " # Se debe almacenar un contenido." do
			@m1.M
		end
	end
end

describe MathExpansion::Matriz_Densa do

end


describe MathExpansion::Matriz_Dispersa do

end
