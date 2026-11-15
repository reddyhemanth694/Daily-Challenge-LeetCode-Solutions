=begin
Brute Force

def num_of_subarrays(arr)
  mod = 1_000_000_007
  n = arr.size
  ans = 0
  (0...n).each do |i|
    (i...n).each do |j|
      ans += 1 if arr[i..j].sum.odd?
    end
  end
  ans % mod
end
=end

=begin
Better Approach

def num_of_subarrays(arr)
  mod = 1_000_000_007
  n = arr.size
  ans = 0
  (0...n).each do |i|
    sum = 0
    (i...n).each do |j|
      sum += arr[j]
      ans += 1 if sum.odd?
    end
  end
  ans % mod
end
=end

def num_of_subarrays(arr)
  mod = 1_000_000_007
  odd = 0
  even = 1
  sum = 0
  ans = 0
  arr.each do |x|
    sum += x
    if sum.odd?
      ans += even
      odd += 1
    else
      ans += odd
      even += 1
    end
  end
  ans % mod
end