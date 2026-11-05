=begin
Brute Force

def find_the_distance_value(arr1, arr2, d)
  arr1.count { |a| arr2.all? { |b| (a - b).abs > d } }
end
=end

=begin
Better Approach

def find_the_distance_value(arr1, arr2, d)
  b = arr2.sort
  arr1.count do |a|
    i = b.bsearch_index { |v| v >= a - d }
    i.nil? || b[i] > a + d
  end
end
=end

def find_the_distance_value(arr1, arr2, d)
  pre = Array.new(2202, 0)
  arr2.each { |v| pre[v + 1101] += 1 }
  (1...2202).each { |i| pre[i] += pre[i - 1] }
  arr1.count { |a| pre[a + d + 1101] == pre[a - d + 1100] }
end