/*
Brute Force

class Solution {
    function solve($s, $i) {
        $n = strlen($s);
        if ($i == $n) return 0;
        $best = $n;
        $ones = 0;
        for ($j = $i; $j < $n; $j++) {
            if ($s[$j] === '1') $ones++;
            $len = $j - $i + 1;
            if ($len % 2 == 0) $best = min($best, min($ones, $len - $ones) + $this->solve($s, $j + 1));
        }
        return $best;
    }

    function minChanges($s) {
        return $this->solve($s, 0);
    }
}
*/

/*
Better Approach

class Solution {
    function minChanges($s) {
        $n = strlen($s);
        $dp = array_fill(0, $n + 1, $n);
        $dp[0] = 0;
        for ($i = 0; $i < $n; $i += 2) {
            $ones = 0;
            for ($j = $i; $j < $n; $j++) {
                if ($s[$j] === '1') $ones++;
                $len = $j - $i + 1;
                if ($len % 2 == 0) $dp[$j + 1] = min($dp[$j + 1], $dp[$i] + min($ones, $len - $ones));
            }
        }
        return $dp[$n];
    }
}
*/

class Solution {
    function minChanges($s) {
        $ans = 0;
        for ($i = 0; $i < strlen($s); $i += 2) {
            if ($s[$i] !== $s[$i + 1]) $ans++;
        }
        return $ans;
    }
}