=begin
Brute Force

def longest_monotonic_subarray(nums)
  n = nums.size
  res = 1
  n.times do |i|
    inc = 1
    inc += 1 while i + inc < n && nums[i + inc] > nums[i + inc - 1]
    dec = 1
    dec += 1 while i + dec < n && nums[i + dec] < nums[i + dec - 1]
    res = [res, inc, dec].max
  end
  res
end
=end

=begin
Better Approach

def longest_monotonic_subarray(nums)
  res = len = 1
  (1...nums.size).each do |i|
    len = nums[i] > nums[i - 1] ? len + 1 : 1
    res = len if len > res
  end
  len = 1
  (1...nums.size).each do |i|
    len = nums[i] < nums[i - 1] ? len + 1 : 1
    res = len if len > res
  end
  res
end
=end

def longest_monotonic_subarray(nums)
  res = inc = dec = 1
  (1...nums.size).each do |i|
    inc = nums[i] > nums[i - 1] ? inc + 1 : 1
    dec = nums[i] < nums[i - 1] ? dec + 1 : 1
    res = [res, inc, dec].max
  end
  res
end