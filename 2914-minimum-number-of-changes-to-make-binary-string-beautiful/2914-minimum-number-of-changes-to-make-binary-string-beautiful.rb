=begin
Brute Force

def min_changes(s)
  n = s.size
  solve = lambda do |i|
    return 0 if i == n
    best = n
    ones = 0
    (i...n).each do |j|
      ones += 1 if s[j] == '1'
      len = j - i + 1
      best = [best, [ones, len - ones].min + solve.(j + 1)].min if len.even?
    end
    best
  end
  solve.(0)
end
=end

=begin
Better Approach

def min_changes(s)
  n = s.size
  dp = Array.new(n + 1, n)
  dp[0] = 0
  (0...n).step(2) do |i|
    ones = 0
    (i...n).each do |j|
      ones += 1 if s[j] == '1'
      len = j - i + 1
      dp[j + 1] = [dp[j + 1], dp[i] + [ones, len - ones].min].min if len.even?
    end
  end
  dp[n]
end
=end

def min_changes(s)
  (0...s.size).step(2).count { |i| s[i] != s[i + 1] }
end