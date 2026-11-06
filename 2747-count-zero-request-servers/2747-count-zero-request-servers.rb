=begin
Brute Force

def count_servers(n, logs, x, queries)
  queries.map do |q|
    seen = {}
    logs.each { |s, t| seen[s] = true if t >= q - x && t <= q }
    n - seen.size
  end
end
=end

=begin
Better Approach

def count_servers(n, logs, x, queries)
  lg = logs.sort_by { |_, t| t }
  m = lg.size
  stamp = Array.new(n + 1, -1)
  queries.each_with_index.map do |q, i|
    j = lg.bsearch_index { |_, t| t >= q - x } || m
    cnt = 0
    while j < m && lg[j][1] <= q
      s = lg[j][0]
      if stamp[s] != i
        stamp[s] = i
        cnt += 1
      end
      j += 1
    end
    n - cnt
  end
end
=end

def count_servers(n, logs, x, queries)
  lg = logs.sort_by { |_, t| t }
  m = lg.size
  cnt = Array.new(n + 1, 0)
  ans = Array.new(queries.size, 0)
  l = r = distinct = 0
  (0...queries.size).sort_by { |i| queries[i] }.each do |i|
    q = queries[i]
    while r < m && lg[r][1] <= q
      s = lg[r][0]
      distinct += 1 if cnt[s] == 0
      cnt[s] += 1
      r += 1
    end
    while l < r && lg[l][1] < q - x
      s = lg[l][0]
      cnt[s] -= 1
      distinct -= 1 if cnt[s] == 0
      l += 1
    end
    ans[i] = n - distinct
  end
  ans
end