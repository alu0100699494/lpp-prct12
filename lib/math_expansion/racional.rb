require "./lib/math_expansion/gcd.rb"

module MathExpansion  
# Esta clase permite representar números racionales de la forma _numerador/denominador_.
  class Fraccion
    #--
    # Módulos usados
    #++
    include Comparable

    #--
    # Métodos principales
    #++
    # Los parámetros que se pasan son el numerador y el denominador, respectivamente:
    # * *x*: Numerador.
    # * *y*: Denominador.
      def initialize(x,y)
          raise ArgumentError , 'Argumentos no enteros.' unless x.is_a? Fixnum and y.is_a? Fixnum
          raise ArgumentError , 'Denominador nulo.' unless y != 0

          @num, @den = x, y
          reducir
          #--
          # En caso de ser negativa, la fracción será -a/b, y no a/(-b)
          #++
          if(@num < 0 && @den < 0)
              @num = -@num
              @den = -@den
          elsif(@den < 0)
              @den = -@den
              @num = -@num
          end
      end
    # Devuelve el valor del numerador.
      def num()
          @num
      end
    # Devuelve el valor del denominador.
      def den()
          @den
      end
    # Este método permite invertir el orden de los operandos para posibilitar las operaciones aritméticas.
      def coerce(other)
          [Fraccion.new(other,1),self]  
      end
    # Devuelve la fracción nula (con valor 0) _0/1_.
      def self.null
          Fraccion.new(0,1)
      end
    # Devuelve la representación de la fracción como "_numerador/denominador_".
      def to_s
          "#{@num}/#{@den}"
      end
    # Reduce la fracción a su mínima expresión.
      def reducir
          mcd = MathExpansion::gcd(@num,@den)
          @num = @num / mcd
          @den = @den / mcd
      end
    # Permite usar números en representación de punto flotante en el numerador y en el denominador.
      def to_f
          @num.to_f/@den.to_f
      end
    
    #--
    # Operadores unarios
    #++
    
    # Devulve el valor absoluto de una fracción
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
    # Devuelve la fracción recíproca.
      def reciprocal
          aux = @num
          @num = @den
          @den = aux
          Fraccion.new(@num,@den)
      end
    # Devuelve la fracción con signo negativo.
      def -@ # Operación negación
          Fraccion.new(-@num, @den)
      end
    
    #--
    # Operadores aritméticos
    #++

    # Permite sumar otro elemento a una fracción.
      def +(other) #-- # Operación suma #++
          if(other.respond_to? :den and other.respond_to? :num)
            Fraccion.new(@num*other.den + @den*other.num, @den*other.den) # a/b + c/d = (a*d + b*c)/(b*d)
          else
            Fraccion.new(@num + @den*other, @den) # a/b + c = (a + b*c)/b
          end
      end
    # Permite restar otro elemento a una fracción.
      def -(other) #-- # Operación resta #++
          if(other.respond_to? :den and other.respond_to? :num)
            Fraccion.new(@num*other.den - @den*other.num, @den*other.den) # a/b - c/d = (a*d - b*c)/(b*d)
          else
            Fraccion.new(@num - @den*other, @den) # a/b - c = (a - b*c)/b
          end
      end
    # Permite multiplicar otro elemento a una fracción.
      def *(other) #-- # Operación producto #++
          if(other.respond_to? :den and other.respond_to? :num)
            if(@num*other.num == 0)
              Fraccion.null
            else
              Fraccion.new(@num*other.num, @den*other.den) # a/b * c/d = (a*c)/(b*d)
            end
          else
            Fraccion.new(@num*other, @den)  # a/b * c = (a*c)/b
          end
      end
    # Permite dividir otro elemento a una fracción.
      def /(other) #-- # Operación división #++
          if(other.respond_to? :den and other.respond_to? :num)
            if(other.num == 0)
              Fraccion.null
            else
              Fraccion.new(@num*other.den, @den*other.num) # a/b / c/d = (a*d)/(b*c)
            end
          else
            if(other == 0)
              Fraccion.null
            else
              Fraccion.new(@num, @den*other)
            end
          end
      end
    # Permite obtener el resto entre la división de una fracción y otro elemento.
      def %(other) #-- # Operación módulo #++
          raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion
    
          Fraccion.new(0,1) #-- # Resto de una división de fracciones = siempre nulo (0/1) #++
      end
   
    #--
    # Operadores comparacionales
    #++

    # Este método permite hacer operaciones comparacionales entre una fracción y otro elemento.
      def <=> (other)
          #-- #raise ArgumentError, 'Argumento no racional' unless other.is_a? Fraccion #++
        
          #-- # a/b <=> c/d -> (a*d)/(b*d) <=> (c*b)/(d*b) -> a*d <=> c*b #++
          if(other.respond_to? :den and other.respond_to? :num)
            (@num * other.den) <=> (other.num * @den)
          else
            (@num.to_f / @den.to_f) <=> (other)
          end
      end
  end
end
