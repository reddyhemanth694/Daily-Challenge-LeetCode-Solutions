=begin
Brute Force

def minimum_cost(cost1, cost2, cost_both, need1, need2)
  (0..[need1, need2].max).map { |k| k * cost_both + [0, need1 - k].max * cost1 + [0, need2 - k].max * cost2 }.min
end
=end

=begin
Better Approach

def minimum_cost(cost1, cost2, cost_both, need1, need2)
  total = ->(k) { k * cost_both + [0, need1 - k].max * cost1 + [0, need2 - k].max * cost2 }
  lo = 0
  hi = [need1, need2].max
  while lo < hi
    mid = (lo + hi) / 2
    if total.(mid) <= total.(mid + 1)
      hi = mid
    else
      lo = mid + 1
    end
  end
  total.(lo)
end
=end

def minimum_cost(cost1, cost2, cost_both, need1, need2)
  both = [need1, need2].min
  both * [cost_both, cost1 + cost2].min + (need1 - both) * [cost1, cost_both].min + (need2 - both) * [cost2, cost_both].min
end