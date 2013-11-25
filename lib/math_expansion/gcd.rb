module MathExpansion

# Este método devolverá el máximo común divisor entre los parámetros a y b
  def self.gcd(a, b)
    a, b = a.abs, b.abs
    while b != 0
      a, b = b, a % b
    end
    a
  end
end
