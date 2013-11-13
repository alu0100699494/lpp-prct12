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
	before :all do
		class Fixnum
			def self.null
				0
			end
		end
		
		class String
			def self.null
				""
			end
		end
		
		class Float
			def self.null
				0.0
			end
		end
		
		# Etc
	end
	
	before :each do
		@m1 = MathExpansion::Matriz_Densa.new(2,2)
		@m2 = MathExpansion::Matriz_Densa.new(2,2)
		
		@m1.set(0,0,1)
		@m1.set(0,1,2)
		@m1.set(1,0,3)
		@m1.set(1,1,4)
		
		@m2.set(0,0,5)
		@m2.set(0,1,6)
		@m2.set(1,0,7)
		@m2.set(1,1,8)
		
	end
	describe " # Almacenamiento de matrices. " do
		it " # Se debe poder acceder a los datos almacenados en la matriz " do		
			@m1.get(0,0).should eq(1)
			@m1.get(0,1).should eq(2)
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
			@m1.to_s.should == "3.0\t-6\t\n3\t4\t\n"
		end
	end
end


describe MathExpansion::Matriz_Dispersa do
	before :all do
		class Fixnum
			def self.null
				0
			end
		end
		
		class String
			def self.null
				""
			end
		end
		
		class Float
			def self.null
				0.0
			end
		end
		
		# Etc
	end
	
	before :each do
		@m1 = MathExpansion::Matriz_Densa.new(3,2)
		
		@m1.set(0,0,0)
		@m1.set(0,1,0)
		
		@m1.set(1,0,1)
		@m1.set(1,1,3)
		
		@m1.set(2,0,0)
		@m1.set(2,1,0)
		
		@md1 = MathExpansion::Matriz_Dispersa.copy(@m1)
		@md2 = MathExpansion::Matriz_Dispersa.new(5, 5)
		
	end
	
    describe " # Almacenamiento de matrices. " do
		it " # Se debe poder crear matrices dispersas vacias o a partir de matrices densas." do		
			MathExpansion::Matriz_Dispersa.new(5, 5)
			MathExpansion::Matriz_Dispersa.copy(@m1)
		end
		
		it " # Se debe poder calcular el porcentaje de elementos nulos de la matriz dispersa." do
		    @md2.null_percent.should == 1.0
			@md1.null_percent.should == 4.0/6.0
		end
		
		it " # Se debe poder acceder a los elementos de la matriz dispersa." do
		    @md2.get(0,0).should == 0
			
			@md1.get(1,1).should == 3
			@md1.get(1,0).should == 1
			@md1.get(0,0).should == 0
			
			@md1.get(10,10).should == nil
		end
		
		it " # Se deben poder modificar los elementos de la matriz dispersa." do
		    @md2.set(0,0,1)
			@md2.set(0,0).should == 1
			
			@md1.set(1,1,4)
			@md1.set(1,0,2)
			@md1.get(1,1).should == 4
			@md1.get(1,0).should == 2
			
			@md1.get(0,0).should == 0
		end
	end
end
