require "./lib/math_expansion/matriz.rb"
require "./lib/math_expansion/matriz_dispersa.rb"
require "./lib/math_expansion/matriz_densa.rb"
require "./lib/math_expansion/matriz_operaciones.rb"

module MathExpansion
  class MatrizDSL < Matriz
      attr_accessor :resultado
      
    def initialize(tipo_operacion, &block)
      raise ArgumentError , 'Tipo invalido' unless str.is_a? String
     
      @operandos = []
      @resultado = nil
      @modo = nil
      @resultado = nil
      @operacion = nil
      #@contador_operandos = 0
      
      case tipo_operacion
        when "suma"
          @operacion = :suma
        when "resta"
          @operacion = :resta
        when "multiplicacion"
          @operacion = :multiplicacion
        when "lectura"
          @operacion = :lectura
        else
          puts "ERROR: Unknown option", tipo_operacion
          @operacion = :lectura
      end
      
    end
    
    protected
    def operando(matriz_bidimensional)
      raise ArgumentError , 'Tipo invalido' unless matriz_bidimensional.is_a? Array
      
      operando << Matriz_Densa.new(matriz_bidimensional)
    end
    
    def option(str)
      raise ArgumentError , 'Tipo invalido' unless str.is_a? String
      str.downcase!
      
      case str
        when "densa"
          @resultado = :densa
        when "dispersa"
          @resultado = :dispersa
        when "auto"
          @resultado = :auto
        when "consola"
          @modo = :consola
        when "fichero"
          @modo = :fichero
        else
          puts "ERROR: Unknown option", str
          @resultado = :auto
          @modo = :consola
      end
    end
    
    def run
      case @operacion
        when :suma
        
        
        when :resta
        
        
        when :multiplicacion
        
        
        when :lectura
        
        
        else
        
      end
    end
    
    public
    
  end
end