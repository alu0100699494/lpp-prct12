require "./lib/math_expansion/matriz.rb"
require "./lib/math_expansion/matriz_dispersa.rb"
require "./lib/math_expansion/matriz_densa.rb"
require "./lib/math_expansion/matriz_operaciones.rb"

module MathExpansion
  class MatrizDSL < Matriz
      attr_accessor :resultado
      
    def initialize(tipo_operacion, &block)
      raise ArgumentError , 'Tipo invalido' unless tipo_operacion.is_a? String
     
      @operandos = []
      @modo_resultado = :auto
      @resultado = nil
      @modo = :consola
      @operacion = :lectura
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
      end
      
      if block_given?  
        if block.arity == 1
          yield self
        else
          instance_eval &block 
        end
      end
      
      run
    end
    
    protected
    def operando(matriz_bidimensional)
      raise ArgumentError , 'Tipo invalido' unless matriz_bidimensional.is_a? Array
      
      @operandos << Matriz_Densa.leerArray(matriz_bidimensional)
    end
    
    def opcion(str_)
      raise ArgumentError , 'Tipo invalido' unless str_.is_a? String
      str = str_.downcase
      
      case str
        when "densa"
          @modo_resultado = :densa
        when "dispersa"
          @modo_resultado = :dispersa
        when "auto"
          @modo_resultado = :auto
        when "consola"
          @modo = :consola
        when "fichero"
          @modo = :fichero
        when "nada"
          @modo = :nada
        else
          puts "ERROR: Unknown option", str
      end
    end
    
    def run
      case @operacion
        when :lectura
          raise RuntimeError , 'Numero de operandos invalidos' unless @operandos.size() == 1
          
          @resultado = @operandos[0] # Densa
          if(@modo_resultado == :dispersa)
            @resultado = Matriz_Densa.new(@operando[0])
          elsif(@modo_resultado == :auto)
            if(@resultado.null_percent > 0.6) # Pasar a dispersa si tiene más de un 60% de elementos nulos
              @resultado = Matriz_Dispersa.new(@operando[0])
            end
          end
          
          if(@modo == :consola)
            puts @resultado.to_s
          elsif(@modo == :fichero)
            puts "fichero lolwut omg lalalala"
          end
        # Fin lectura
        #when :suma
        
        
        #when :resta
        
        
        #when :multiplicacion
        
        else
          puts "ERROR: Unknown option", @operacion
      end
    end
    
  end
end