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
			@m1.contenido
		end
	end
end

describe MathExpansion::Matriz_Densa do
	before :each do
		@m1 = MathExpansion::Matriz_Densa.new(2,2)
		@m2 = MathExpansion::Matriz_Densa.new(2,2)
		
		@m1.set(0,0).should eq(1)
		@m1.set(0,1).should eq(2)
		@m1.set(1,0).should eq(3)
		@m1.set(1,1).should eq(4)
		
		@m2.set(0,0).should eq(2)
		@m2.set(0,1).should eq(4)
		@m2.set(1,0).should eq(6)
		@m2.set(1,1).should eq(8)
		
	end
	describe " # Almacenamiento de matrices. " do
		it " # Se debe poder acceder a los datos almacenados en la matriz " do		
			@m1.get(0,0).should eq(1)
			@m1.get(0,1).should eq(3)
		end
		it " # Se deben poder modificar los datos almacenados en la matriz " do		
			@m1.set(0,0,5)
			@m1.get(0,0).should eq(5)
			
			@m1.set(0,1,8)
			@m1.get(0,1).should eq(8)
		end
		it " # Se deben poder almacenar todo tipo de datos numericos (flotantes, enteros, etc...) " do		
			@m1.set(0,0,3.0)
			@m1.set(0,1,-6)
			@m1.to_s.should == "3.0\t2\t\n-6\t4\t\n"
		end
	end
end


describe MathExpansion::Matriz_Dispersa do

end
