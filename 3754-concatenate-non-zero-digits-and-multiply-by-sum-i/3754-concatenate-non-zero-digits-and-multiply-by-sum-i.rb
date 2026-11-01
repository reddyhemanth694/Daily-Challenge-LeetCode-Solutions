=begin
Brute Force

def sum_and_multiply(n)
  t = n.to_s.delete("0")
  return 0 if t.empty?
  t.to_i * t.chars.sum(&:to_i)
end
=end

=begin
Better Approach

def sum_and_multiply(n)
  digits = []
  while n > 0
    digits << n % 10
    n /= 10
  end
  x = sum = 0
  digits.reverse_each do |d|
    next if d.zero?
    x = x * 10 + d
    sum += d
  end
  x * sum
end
=end

def sum_and_multiply(n)
  x = sum = 0
  p = 1
  while n > 0
    d = n % 10
    if d != 0
      x += d * p
      sum += d
      p *= 10
    end
    n /= 10
  end
  x * sum
end