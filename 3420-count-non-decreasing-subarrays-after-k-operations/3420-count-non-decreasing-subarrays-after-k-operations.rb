=begin
Brute Force

def count_non_decreasing_subarrays(nums, k)
  n = nums.size
  ans = 0
  n.times do |l|
    mx = 0
    cost = 0
    (l...n).each do |r|
      mx = nums[r] if nums[r] > mx
      cost += mx - nums[r]
      break if cost > k
      ans += 1
    end
  end
  ans
end
=end

=begin
Better Approach

def count_non_decreasing_subarrays(nums, k)
  n = nums.size
  lg = n.bit_length
  pre = [0]
  nums.each { |v| pre << pre[-1] + v }
  nxt = Array.new(n + 1, n)
  st = []
  (n - 1).downto(0) do |i|
    st.pop while !st.empty? && nums[st[-1]] <= nums[i]
    nxt[i] = st.empty? ? n : st[-1]
    st << i
  end
  up = [nxt]
  sum = [Array.new(n + 1) { |i| i < n ? nums[i] * (nxt[i] - i) - (pre[nxt[i]] - pre[i]) : 0 }]
  (1...lg).each do |j|
    pu = up[j - 1]
    ps = sum[j - 1]
    up << Array.new(n + 1) { |i| pu[pu[i]] }
    sum << Array.new(n + 1) { |i| ps[i] + ps[pu[i]] }
  end
  ans = 0
  n.times do |l|
    cur = l
    acc = 0
    (lg - 1).downto(0) do |j|
      if cur < n && acc + sum[j][cur] <= k
        acc += sum[j][cur]
        cur = up[j][cur]
      end
    end
    if cur == n
      ans += n - l
      next
    end
    lo = cur
    hi = nxt[cur] - 1
    while lo < hi
      mid = (lo + hi + 1) / 2
      if acc + nums[cur] * (mid - cur + 1) - (pre[mid + 1] - pre[cur]) <= k
        lo = mid
      else
        hi = mid - 1
      end
    end
    ans += lo - l + 1
  end
  ans
end
=end

def count_non_decreasing_subarrays(nums, k)
  n = nums.size
  dq = Array.new(n, 0)
  head = tail = n
  r = n - 1
  ans = cost = 0
  l = n - 1
  while l >= 0
    while head < tail && nums[dq[head]] <= nums[l]
      i = dq[head]
      head += 1
      stop = head < tail ? dq[head] : r + 1
      cost += (nums[l] - nums[i]) * (stop - i)
    end
    head -= 1
    dq[head] = l
    while cost > k
      cost -= nums[dq[tail - 1]] - nums[r]
      tail -= 1 if dq[tail - 1] == r
      r -= 1
    end
    ans += r - l + 1
    l -= 1
  end
  ans
end