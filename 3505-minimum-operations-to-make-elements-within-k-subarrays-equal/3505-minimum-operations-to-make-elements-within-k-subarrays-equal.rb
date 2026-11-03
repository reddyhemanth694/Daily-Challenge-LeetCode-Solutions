=begin
Brute Force

def min_operations(nums, x, k)
  n = nums.size
  window_cost = lambda do |i|
    w = nums[i, x].sort
    med = w[x / 2]
    w.sum { |v| (v - med).abs }
  end
  dfs = lambda do |i, j|
    return 0 if j == 0
    return Float::INFINITY if n - i < j * x
    [dfs.(i + 1, j), window_cost.(i) + dfs.(i + x, j - 1)].min
  end
  dfs.(0, k)
end
=end

=begin
Better Approach

def min_operations(nums, x, k)
  n = nums.size
  cost = (0..n - x).map do |i|
    w = nums[i, x].sort
    med = w[x / 2]
    w.sum { |v| (v - med).abs }
  end
  inf = 1 << 62
  prev = Array.new(n + 1, 0)
  k.times do
    cur = Array.new(n + 1, inf)
    i = x
    while i <= n
      take = prev[i - x] + cost[i - x]
      cur[i] = cur[i - 1] < take ? cur[i - 1] : take
      i += 1
    end
    prev = cur
  end
  prev[n]
end
=end

def fs_up_add(lv, r)
  l = 1
  while l < lv.size
    a = lv[l]
    w = r >> 5
    old = a[w]
    a[w] = old | (1 << (r & 31))
    return if old != 0
    r = w
    l += 1
  end
end

def fs_up_del(lv, r)
  l = 1
  while l < lv.size
    a = lv[l]
    w = r >> 5
    nw = a[w] & ~(1 << (r & 31))
    a[w] = nw
    return if nw != 0
    r = w
    l += 1
  end
end

def fs_next(lv, r)
  l = 0
  while true
    m = lv[l][r >> 5] >> ((r & 31) + 1)
    if m != 0
      r += (m & -m).bit_length
      break
    end
    r >>= 5
    l += 1
  end
  while l > 0
    l -= 1
    m = lv[l][r]
    r = (r << 5) + (m & -m).bit_length - 1
  end
  r
end

def fs_prev(lv, r)
  l = 0
  while true
    m = lv[l][r >> 5] & ((1 << (r & 31)) - 1)
    if m != 0
      r = ((r >> 5) << 5) + m.bit_length - 1
      break
    end
    r >>= 5
    l += 1
  end
  while l > 0
    l -= 1
    r = (r << 5) + lv[l][r].bit_length - 1
  end
  r
end

def min_operations(nums, x, k)
  n = nums.size
  half = (x + 1) / 2
  odd = 2 * half - x
  if x <= 16
    cost = Array.new(n - x + 1) do |i|
      w = nums[i, x].sort
      w.sum - 2 * w[0, half].sum + w[half - 1] * odd
    end
  else
    keys = Array.new(n) { |i| ((nums[i] + 1_000_000) << 17) + i }
    keys.sort!
    rank = Array.new(n, 0)
    val = Array.new(n, 0)
    keys.each_with_index do |key, r|
      rank[key & 131_071] = r
      val[r] = (key >> 17) - 1_000_000
    end
    lv = []
    size = n
    loop do
      size = (size + 31) >> 5
      lv << Array.new(size, 0)
      break if size == 1
    end
    l0 = lv[0]
    first = rank[0, x].sort
    ml = first[half - 1]
    sum_l = 0
    half.times { |t| sum_l += val[first[t]] }
    total = nums[0, x].sum
    x.times do |i|
      r = rank[i]
      w = r >> 5
      old = l0[w]
      l0[w] = old | (1 << (r & 31))
      fs_up_add(lv, w) if old == 0
    end
    cost = Array.new(n - x + 1, 0)
    cost[0] = total - 2 * sum_l + val[ml] * odd
    i = x
    while i < n
      a = nums[i]
      b = nums[i - x]
      ra = rank[i]
      rb = rank[i - x]
      w = ra >> 5
      old = l0[w]
      l0[w] = old | (1 << (ra & 31))
      fs_up_add(lv, w) if old == 0
      if ra < ml
        sum_l += a - val[ml]
        m = l0[ml >> 5] & ((1 << (ml & 31)) - 1)
        ml = m != 0 ? ((ml >> 5) << 5) + m.bit_length - 1 : fs_prev(lv, ml)
      end
      w = rb >> 5
      nw = l0[w] & ~(1 << (rb & 31))
      l0[w] = nw
      fs_up_del(lv, w) if nw == 0
      if rb <= ml
        m = l0[ml >> 5] >> ((ml & 31) + 1)
        ml = m != 0 ? ml + (m & -m).bit_length : fs_next(lv, ml)
        sum_l += val[ml] - b
      end
      total += a - b
      cost[i - x + 1] = total - 2 * sum_l + val[ml] * odd
      i += 1
    end
  end
  inf = 1 << 60
  prev = Array.new(n + 1, 0)
  k.times do |t|
    cur = Array.new(n + 1, inf)
    best = inf
    j = t * x
    lim = n - (k - t) * x
    while j <= lim
      v = prev[j] + cost[j]
      best = v if v < best
      cur[j + x] = best
      j += 1
    end
    prev = cur
  end
  prev[n]
end