/*
Brute Force

class Solution {
    function sumAndMultiply($n) {
        $t = str_replace("0", "", strval($n));
        if ($t === "") return 0;
        return intval($t) * array_sum(str_split($t));
    }
}
*/

/*
Better Approach

class Solution {
    function sumAndMultiply($n) {
        $digits = [];
        for (; $n > 0; $n = intdiv($n, 10)) $digits[] = $n % 10;
        $x = 0;
        $sum = 0;
        for ($i = count($digits) - 1; $i >= 0; $i--) {
            if ($digits[$i] != 0) {
                $x = $x * 10 + $digits[$i];
                $sum += $digits[$i];
            }
        }
        return $x * $sum;
    }
}
*/

class Solution {
    function sumAndMultiply($n) {
        $x = 0;
        $sum = 0;
        $p = 1;
        for (; $n > 0; $n = intdiv($n, 10)) {
            $d = $n % 10;
            if ($d != 0) {
                $x += $d * $p;
                $sum += $d;
                $p *= 10;
            }
        }
        return $x * $sum;
    }
}