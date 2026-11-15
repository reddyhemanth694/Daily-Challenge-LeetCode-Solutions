/*
Brute Force

class Solution {
    function numOfSubarrays($arr) {
        $mod = 1000000007;
        $n = count($arr);
        $ans = 0;
        for ($i = 0; $i < $n; $i++) {
            for ($j = $i; $j < $n; $j++) {
                $sum = 0;
                for ($k = $i; $k <= $j; $k++) $sum += $arr[$k];
                if ($sum % 2 == 1) $ans = ($ans + 1) % $mod;
            }
        }
        return $ans;
    }
}
*/

/*
Better Approach

class Solution {
    function numOfSubarrays($arr) {
        $mod = 1000000007;
        $n = count($arr);
        $ans = 0;
        for ($i = 0; $i < $n; $i++) {
            $sum = 0;
            for ($j = $i; $j < $n; $j++) {
                $sum += $arr[$j];
                if ($sum % 2 == 1) $ans = ($ans + 1) % $mod;
            }
        }
        return $ans;
    }
}
*/

class Solution {
    function numOfSubarrays($arr) {
        $mod = 1000000007;
        $odd = 0;
        $even = 1;
        $sum = 0;
        $ans = 0;
        foreach ($arr as $x) {
            $sum += $x;
            if ($sum % 2 == 1) {
                $ans = ($ans + $even) % $mod;
                $odd++;
            } else {
                $ans = ($ans + $odd) % $mod;
                $even++;
            }
        }
        return $ans;
    }
}