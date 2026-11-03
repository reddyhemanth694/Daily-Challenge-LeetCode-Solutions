/*
Brute Force

class Solution {
    function windowCost($nums, $i, $x) {
        $w = array_slice($nums, $i, $x);
        sort($w);
        $med = $w[intdiv($x, 2)];
        $cost = 0;
        foreach ($w as $v) $cost += abs($v - $med);
        return $cost;
    }

    function dfs($nums, $x, $i, $j) {
        if ($j == 0) return 0;
        if (count($nums) - $i < $j * $x) return PHP_INT_MAX;
        $skip = $this->dfs($nums, $x, $i + 1, $j);
        $take = $this->windowCost($nums, $i, $x) + $this->dfs($nums, $x, $i + $x, $j - 1);
        return min($skip, $take);
    }

    function minOperations($nums, $x, $k) {
        return $this->dfs($nums, $x, 0, $k);
    }
}
*/

/*
Better Approach

class Solution {
    function minOperations($nums, $x, $k) {
        $n = count($nums);
        $cost = [];
        for ($i = 0; $i + $x <= $n; $i++) {
            $w = array_slice($nums, $i, $x);
            sort($w);
            $med = $w[intdiv($x, 2)];
            $c = 0;
            foreach ($w as $v) $c += abs($v - $med);
            $cost[] = $c;
        }
        $inf = PHP_INT_MAX >> 2;
        $prev = array_fill(0, $n + 1, 0);
        for ($j = 1; $j <= $k; $j++) {
            $cur = array_fill(0, $n + 1, $inf);
            for ($i = $x; $i <= $n; $i++) {
                $take = $prev[$i - $x] + $cost[$i - $x];
                $cur[$i] = $cur[$i - 1] < $take ? $cur[$i - 1] : $take;
            }
            $prev = $cur;
        }
        return $prev[$n];
    }
}
*/

class Solution {
    function minOperations($nums, $x, $k) {
        $n = count($nums);
        $vals = array_values(array_unique($nums));
        sort($vals);
        $m = count($vals);
        $pos = array_flip($vals);
        $idx = [];
        foreach ($nums as $v) $idx[] = $pos[$v] + 1;
        $top = 1;
        while ($top * 2 <= $m) $top *= 2;
        $cnt = array_fill(0, $m + 1, 0);
        $sum = array_fill(0, $m + 1, 0);
        $cost = array_fill(0, $n - $x + 1, 0);
        $total = 0;
        $half = intdiv($x + 1, 2);
        for ($i = 0; $i < $n; $i++) {
            for ($p = $idx[$i]; $p <= $m; $p += $p & -$p) {
                $cnt[$p]++;
                $sum[$p] += $nums[$i];
            }
            $total += $nums[$i];
            if ($i >= $x) {
                for ($p = $idx[$i - $x]; $p <= $m; $p += $p & -$p) {
                    $cnt[$p]--;
                    $sum[$p] -= $nums[$i - $x];
                }
                $total -= $nums[$i - $x];
            }
            if ($i >= $x - 1) {
                $p = 0;
                $need = $half;
                $lowCnt = 0;
                $lowSum = 0;
                for ($step = $top; $step > 0; $step >>= 1) {
                    if ($p + $step <= $m && $cnt[$p + $step] < $need) {
                        $p += $step;
                        $need -= $cnt[$p];
                        $lowCnt += $cnt[$p];
                        $lowSum += $sum[$p];
                    }
                }
                $med = $vals[$p];
                $cost[$i - $x + 1] = $med * $lowCnt - $lowSum + ($total - $lowSum) - $med * ($x - $lowCnt);
            }
        }
        $inf = PHP_INT_MAX >> 2;
        $prev = array_fill(0, $n + 1, 0);
        for ($j = 1; $j <= $k; $j++) {
            $cur = array_fill(0, $n + 1, $inf);
            for ($i = $x; $i <= $n; $i++) {
                $take = $prev[$i - $x] + $cost[$i - $x];
                $cur[$i] = $cur[$i - 1] < $take ? $cur[$i - 1] : $take;
            }
            $prev = $cur;
        }
        return $prev[$n];
    }
}