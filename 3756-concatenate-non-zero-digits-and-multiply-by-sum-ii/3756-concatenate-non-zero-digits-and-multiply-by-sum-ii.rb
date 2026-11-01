=begin
Brute Force

def sum_and_multiply(s, queries)
  mod = 1_000_000_007
  queries.map do |l, r|
    x = sum = 0
    (l..r).each do |i|
      d = s.getbyte(i) - 48
      next if d.zero?
      x = (x * 10 + d) % mod
      sum += d
    end
    x * sum % mod
  end
end
=end

=begin
Better Approach

def sum_and_multiply(s, queries)
  mod = 1_000_000_007
  m = s.size
  pre = Array.new(m + 1, 0)
  cnt = Array.new(m + 1, 0)
  sum = Array.new(m + 1, 0)
  m.times do |i|
    d = s.getbyte(i) - 48
    pre[i + 1] = d.zero? ? pre[i] : (pre[i] * 10 + d) % mod
    cnt[i + 1] = cnt[i] + (d.zero? ? 0 : 1)
    sum[i + 1] = sum[i] + d
  end
  queries.map do |l, r|
    r += 1
    x = (pre[r] - pre[l] * 10.pow(cnt[r] - cnt[l], mod)) % mod
    x * (sum[r] - sum[l]) % mod
  end
end
=end

def sum_and_multiply(s, queries)
  mod = 1_000_000_007
  m = s.size
  pre = Array.new(m + 1, 0)
  pw = Array.new(m + 1, 1)
  cnt = Array.new(m + 1, 0)
  sum = Array.new(m + 1, 0)
  m.times do |i|
    d = s.getbyte(i) - 48
    pw[i + 1] = pw[i] * 10 % mod
    pre[i + 1] = d.zero? ? pre[i] : (pre[i] * 10 + d) % mod
    cnt[i + 1] = cnt[i] + (d.zero? ? 0 : 1)
    sum[i + 1] = sum[i] + d
  end
  queries.map do |l, r|
    r += 1
    x = (pre[r] - pre[l] * pw[cnt[r] - cnt[l]]) % mod
    x * (sum[r] - sum[l]) % mod
  end
end