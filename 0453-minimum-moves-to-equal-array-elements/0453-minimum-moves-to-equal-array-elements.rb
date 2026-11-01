=begin
Brute Force

def min_moves(nums)
  moves = 0
  loop do
    mx = nums.index(nums.max)
    return moves if nums[mx] == nums.min
    nums.each_index { |i| nums[i] += 1 if i != mx }
    moves += 1
  end
end
=end

=begin
Better Approach

def min_moves(nums)
  nums.sort!
  moves = 0
  nums.each { |x| moves += x - nums[0] }
  moves
end
=end

def min_moves(nums)
  mn = nums.min
  moves = 0
  nums.each { |x| moves += x - mn }
  moves
end