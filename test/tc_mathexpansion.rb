# Implementar en este fichero las Pruebas Unitarias de nuestra gema

require "./lib/math_expansion.rb"
require "test/unit"

# Fixnum
class Fixnum
        # Devuelve el valor nulo de la clase Fixnum (0).
	def self.null
       		0
	end
end
#String        
class String
        # Devuelve el valor nulo de la clase String (cadena vacía).
	def self.null
       		""
	end
end
#Float
class Float
        # Devuelve el valor nulo de la clase Float (0.0).
	def self.null
       		0.0
	end
end	
	
# Clase de pruebas unitarias.
class Test_Matriz < Test::Unit::TestCase
	# En este método se prueba que la suma de dos matrices densas @m1 y @m2 coincida con una matriz resultado densa @m3.
        def test_simple
		@m1 = MathExpansion::Matriz_Densa.new(2,2)
	        @m2 = MathExpansion::Matriz_Densa.new(2,2)
		@m3 = MathExpansion::Matriz_Densa.new(2,2)
        
        	@m1.set(0,0,1)
        	@m1.set(0,1,2)
        	@m1.set(1,0,3)
        	@m1.set(1,1,4)
        	
        	@m2.set(0,0,5)
        	@m2.set(0,1,6)
        	@m2.set(1,0,7)
        	@m2.set(1,1,8)

		@m3.set(0,0,6)
		@m3.set(0,1,8)
		@m3.set(1,0,10)
		@m3.set(1,1,12)


		assert_equal(@m3.to_s,(@m1+@m2).to_s)
	end
	# En este método se prueba que la resta entre dos matrices dispersas @md1 y @md2 coincida con una matriz dispersa resultado @m3.
	def test_simple2
		@md1 = MathExpansion::Matriz_Dispersa.new(2,2)
		@md2 = MathExpansion::Matriz_Dispersa.new(2,2)
		@m3 = MathExpansion::Matriz_Dispersa.new(2,2)

		@md1.set(0,0,0)
		@md1.set(0,1,0)
		@md1.set(1,0,5)
		@md1.set(1,1,0)

		@md2.set(0,0,0)
		@md2.set(0,1,0)
		@md2.set(1,0,3)
		@md2.set(1,1,0)

		@m3.set(0,0,0)
		@m3.set(0,1,0)
		@m3.set(1,0,2)
		@m3.set(1,1,0)

		assert_equal(@m3.to_s,(@md1-@md2).to_s)


	end
	# En este método se prueba que se de un fallo de tipo (TypeError).
	def test_typecheck
		@m1 = MathExpansion::Matriz_Densa.new(1,1)
		@m2 = MathExpansion::Matriz_Densa.new(1,1)
		@m1.set(0,0,5)
		@m2.set(0,0,"hola")

		assert_raise(TypeError) {@m1+@m2}
	end
	# En este test se hace fallar intencionadamente al programa.
	def test_failure
		@m1 = MathExpansion::Matriz_Densa.new(1,1)
		@m2 = MathExpansion::Matriz_Densa.new(2,2)

		assert_raise(ArgumentError) {@m1*@m2}
	end
end
