=begin
Brute Force

def min_moves(nums)
  moves = 0
  while nums.min != nums.max
    nums[nums.index(nums.min)] += 1
    moves += 1
  end
  moves
end
=end

=begin
Better Approach

def min_moves(nums)
  nums.sort!
  moves = 0
  nums.each { |x| moves += nums[-1] - x }
  moves
end
=end

def min_moves(nums)
  mx = sum = 0
  nums.each do |x|
    mx = x if x > mx
    sum += x
  end
  mx * nums.size - sum
end