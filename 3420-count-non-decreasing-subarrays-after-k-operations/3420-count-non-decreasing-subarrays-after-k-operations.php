/*
Brute Force

class Solution {
    function countNonDecreasingSubarrays($nums, $k) {
        $n = count($nums);
        $ans = 0;
        for ($l = 0; $l < $n; $l++) {
            $mx = 0;
            $cost = 0;
            for ($r = $l; $r < $n; $r++) {
                $mx = max($mx, $nums[$r]);
                $cost += $mx - $nums[$r];
                if ($cost > $k) break;
                $ans++;
            }
        }
        return $ans;
    }
}
*/

/*
Better Approach

class Solution {
    function countNonDecreasingSubarrays($nums, $k) {
        $n = count($nums);
        $lg = 1;
        while ((1 << $lg) <= $n) $lg++;
        $pre = [0];
        for ($i = 0; $i < $n; $i++) $pre[] = $pre[$i] + $nums[$i];
        $nxt = array_fill(0, $n + 1, $n);
        $st = [];
        for ($i = $n - 1; $i >= 0; $i--) {
            while ($st && $nums[end($st)] <= $nums[$i]) array_pop($st);
            $nxt[$i] = $st ? end($st) : $n;
            $st[] = $i;
        }
        $s0 = array_fill(0, $n + 1, 0);
        for ($i = 0; $i < $n; $i++) $s0[$i] = $nums[$i] * ($nxt[$i] - $i) - ($pre[$nxt[$i]] - $pre[$i]);
        $up = [$nxt];
        $sum = [$s0];
        for ($j = 1; $j < $lg; $j++) {
            $pu = $up[$j - 1];
            $ps = $sum[$j - 1];
            $cu = [];
            $cs = [];
            for ($i = 0; $i <= $n; $i++) {
                $cu[] = $pu[$pu[$i]];
                $cs[] = $ps[$i] + $ps[$pu[$i]];
            }
            $up[] = $cu;
            $sum[] = $cs;
        }
        $ans = 0;
        for ($l = 0; $l < $n; $l++) {
            $cur = $l;
            $acc = 0;
            for ($j = $lg - 1; $j >= 0; $j--) {
                if ($cur < $n && $acc + $sum[$j][$cur] <= $k) {
                    $acc += $sum[$j][$cur];
                    $cur = $up[$j][$cur];
                }
            }
            if ($cur == $n) {
                $ans += $n - $l;
                continue;
            }
            $lo = $cur;
            $hi = $nxt[$cur] - 1;
            while ($lo < $hi) {
                $mid = intdiv($lo + $hi + 1, 2);
                if ($acc + $nums[$cur] * ($mid - $cur + 1) - ($pre[$mid + 1] - $pre[$cur]) <= $k) $lo = $mid;
                else $hi = $mid - 1;
            }
            $ans += $lo - $l + 1;
        }
        return $ans;
    }
}
*/

class Solution {
    function countNonDecreasingSubarrays($nums, $k) {
        $n = count($nums);
        $dq = array_fill(0, $n, 0);
        $head = $tail = $n;
        $r = $n - 1;
        $ans = $cost = 0;
        for ($l = $n - 1; $l >= 0; $l--) {
            while ($head < $tail && $nums[$dq[$head]] <= $nums[$l]) {
                $i = $dq[$head++];
                $stop = $head < $tail ? $dq[$head] : $r + 1;
                $cost += ($nums[$l] - $nums[$i]) * ($stop - $i);
            }
            $dq[--$head] = $l;
            while ($cost > $k) {
                $cost -= $nums[$dq[$tail - 1]] - $nums[$r];
                if ($dq[$tail - 1] == $r) $tail--;
                $r--;
            }
            $ans += $r - $l + 1;
        }
        return $ans;
    }
}