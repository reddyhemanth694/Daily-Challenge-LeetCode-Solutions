/*
Brute Force

class Solution {
    function countServers($n, $logs, $x, $queries) {
        $ans = [];
        foreach ($queries as $q) {
            $seen = [];
            foreach ($logs as [$s, $t])
                if ($t >= $q - $x && $t <= $q) $seen[$s] = true;
            $ans[] = $n - count($seen);
        }
        return $ans;
    }
}
*/

/*
Better Approach

class Solution {
    function countServers($n, $logs, $x, $queries) {
        usort($logs, fn($a, $b) => $a[1] <=> $b[1]);
        $m = count($logs);
        $stamp = array_fill(0, $n + 1, -1);
        $ans = [];
        foreach ($queries as $i => $q) {
            $lo = 0;
            $hi = $m;
            while ($lo < $hi) {
                $mid = intdiv($lo + $hi, 2);
                if ($logs[$mid][1] < $q - $x) $lo = $mid + 1;
                else $hi = $mid;
            }
            $cnt = 0;
            for ($j = $lo; $j < $m && $logs[$j][1] <= $q; $j++) {
                $s = $logs[$j][0];
                if ($stamp[$s] !== $i) {
                    $stamp[$s] = $i;
                    $cnt++;
                }
            }
            $ans[] = $n - $cnt;
        }
        return $ans;
    }
}
*/

class Solution {
    function countServers($n, $logs, $x, $queries) {
        usort($logs, fn($a, $b) => $a[1] <=> $b[1]);
        $m = count($logs);
        $cnt = array_fill(0, $n + 1, 0);
        $ans = array_fill(0, count($queries), 0);
        asort($queries);
        $l = $r = $distinct = 0;
        foreach ($queries as $i => $q) {
            while ($r < $m && $logs[$r][1] <= $q) {
                if ($cnt[$logs[$r][0]]++ == 0) $distinct++;
                $r++;
            }
            while ($l < $r && $logs[$l][1] < $q - $x) {
                if (--$cnt[$logs[$l][0]] == 0) $distinct--;
                $l++;
            }
            $ans[$i] = $n - $distinct;
        }
        return $ans;
    }
}