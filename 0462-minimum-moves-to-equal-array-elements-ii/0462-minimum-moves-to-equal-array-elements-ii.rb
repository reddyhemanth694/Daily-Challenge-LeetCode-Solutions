=begin
Brute Force

def min_moves2(nums)
  best = nil
  nums.each do |x|
    cost = 0
    nums.each { |a| cost += (a - x).abs }
    best = cost if best.nil? || cost < best
  end
  best
end
=end

=begin
Better Approach

def min_moves2(nums)
  sorted = nums.sort
  median = sorted[sorted.size / 2]
  sorted.sum { |a| (a - median).abs }
end
=end

def min_moves2(nums)
  arr = nums
  k = nums.size / 2
  median = nil
  loop do
    pivot = arr.sample
    less = arr.select { |x| x < pivot }
    greater = arr.select { |x| x > pivot }
    equal = arr.size - less.size - greater.size
    if k < less.size
      arr = less
    elsif k < less.size + equal
      median = pivot
      break
    else
      k -= less.size + equal
      arr = greater
    end
  end
  nums.sum { |a| (a - median).abs }
end