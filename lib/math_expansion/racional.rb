require "./lib/math_expansion/gcd.rb"

module MathExpansion  
  class Fraccion
  	# Módulos usados
	include Comparable

	# Métodos principales
	  def initialize(x,y)
	  	  raise ArgumentError , 'Argumentos no enteros.' unless x.is_a? Fixnum and y.is_a? Fixnum
          raise ArgumentError , 'Denominador nulo.' unless y != 0

		  @num, @den = x, y
		  reducir
		
		  # En caso de ser negativa, la fracción será -a/b, y no a/(-b)
		  if(@num < 0 && @den < 0)
			  @num = -@num
			  @den = -@den
		  elsif(@den < 0)
			  @den = -@den
			  @num = -@num
		  end
	  end
	
	  def num()
		  @num
	  end
	
	  def den()
		  @den
	  end

	  def coerce(other)
		  [Fraccion.new(other,1),self]	
	  end

	  def to_s
		  "#{@num}/#{@den}"
	  end
	
	  def reducir
		  mcd = MathExpansion::gcd(@num,@den)
		  @num = @num / mcd
		  @den = @den / mcd
	  end
	
	  def to_f
		  @num.to_f/@den.to_f
	  end
	
    # Operadores unarios
	  def abs
	      a, b = @num, @den
		  if @num < 0
			  a = @num * (-1)
		  end
		  if @den < 0
			  b = @den * (-1)
		  end
		  Fraccion.new(a.to_i,b.to_i)
	  end
	
	  def reciprocal
		  aux = @num
		  @num = @den
		  @den = aux
		  Fraccion.new(@num,@den)
	  end
	
	  def -@ # Operación negación
		  Fraccion.new(-@num, @den)
	  end

	# Operadores aritméticos
	  def +(other) # Operación suma
		  raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
		  Fraccion.new(@num*other.den + @den*other.num, @den*other.den) # a/b + c/d = (a*d + b*c)/(b*d)
	  end
	
	  def -(other) # Operación resta
		  raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
	
		  Fraccion.new(@num*other.den - @den*other.num, @den*other.den) # a/b - c/d = (a*d - b*c)/(b*d)
	  end
	  
	  def *(other) # Operación producto
		  raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
	
		  Fraccion.new(@num*other.num, @den*other.den) # a/b * c/d = (a*c)/(b*d)
	  end

	  def /(other) # Operación división
		  raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
	
		  Fraccion.new(@num*other.den, @den*other.num) # a/b / c/d = (a*d)/(b*c)
	  end
	
	  def %(other) # Operación módulo
		  raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
	
		  Fraccion.new(0,1) # Resto de una división de fracciones = siempre nulo (0/1)
	  end
	
    # Operadores comparacionales
	  def <=> (other)
		  raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
		
		  # a/b <=> c/d -> (a*d)/(b*d) <=> (c*b)/(d*b) -> a*d <=> c*b
		  (@num * other.den) <=> (other.num * @den)
	  end
  end
end
