/*
Brute Force

class Solution {
    function sumAndMultiply($s, $queries) {
        $mod = 1000000007;
        $ans = [];
        foreach ($queries as [$l, $r]) {
            $x = 0;
            $sum = 0;
            for ($i = $l; $i <= $r; $i++) {
                $d = ord($s[$i]) - 48;
                if ($d != 0) {
                    $x = ($x * 10 + $d) % $mod;
                    $sum += $d;
                }
            }
            $ans[] = $x * $sum % $mod;
        }
        return $ans;
    }
}
*/

/*
Better Approach

class Solution {
    function power($b, $e) {
        $mod = 1000000007;
        $r = 1;
        while ($e > 0) {
            if ($e & 1) $r = $r * $b % $mod;
            $b = $b * $b % $mod;
            $e >>= 1;
        }
        return $r;
    }

    function sumAndMultiply($s, $queries) {
        $mod = 1000000007;
        $m = strlen($s);
        $pre = array_fill(0, $m + 1, 0);
        $cnt = array_fill(0, $m + 1, 0);
        $sum = array_fill(0, $m + 1, 0);
        for ($i = 0; $i < $m; $i++) {
            $d = ord($s[$i]) - 48;
            $pre[$i + 1] = $d != 0 ? ($pre[$i] * 10 + $d) % $mod : $pre[$i];
            $cnt[$i + 1] = $cnt[$i] + ($d != 0 ? 1 : 0);
            $sum[$i + 1] = $sum[$i] + $d;
        }
        $ans = [];
        foreach ($queries as [$l, $r]) {
            $r++;
            $x = (($pre[$r] - $pre[$l] * $this->power(10, $cnt[$r] - $cnt[$l])) % $mod + $mod) % $mod;
            $ans[] = $x * ($sum[$r] - $sum[$l]) % $mod;
        }
        return $ans;
    }
}
*/

class Solution {
    function sumAndMultiply($s, $queries) {
        $mod = 1000000007;
        $m = strlen($s);
        $pre = array_fill(0, $m + 1, 0);
        $pw = array_fill(0, $m + 1, 1);
        $cnt = array_fill(0, $m + 1, 0);
        $sum = array_fill(0, $m + 1, 0);
        for ($i = 0; $i < $m; $i++) {
            $d = ord($s[$i]) - 48;
            $pw[$i + 1] = $pw[$i] * 10 % $mod;
            $pre[$i + 1] = $d != 0 ? ($pre[$i] * 10 + $d) % $mod : $pre[$i];
            $cnt[$i + 1] = $cnt[$i] + ($d != 0 ? 1 : 0);
            $sum[$i + 1] = $sum[$i] + $d;
        }
        $ans = [];
        foreach ($queries as [$l, $r]) {
            $r++;
            $x = (($pre[$r] - $pre[$l] * $pw[$cnt[$r] - $cnt[$l]]) % $mod + $mod) % $mod;
            $ans[] = $x * ($sum[$r] - $sum[$l]) % $mod;
        }
        return $ans;
    }
}