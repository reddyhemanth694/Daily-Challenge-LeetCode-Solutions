/*
Brute Force

class Solution {
    function longestMonotonicSubarray($nums) {
        $n = count($nums);
        $res = 1;
        for ($i = 0; $i < $n; $i++) {
            $inc = 1;
            $dec = 1;
            while ($i + $inc < $n && $nums[$i + $inc] > $nums[$i + $inc - 1]) $inc++;
            while ($i + $dec < $n && $nums[$i + $dec] < $nums[$i + $dec - 1]) $dec++;
            $res = max($res, $inc, $dec);
        }
        return $res;
    }
}
*/

/*
Better Approach

class Solution {
    function longestMonotonicSubarray($nums) {
        $res = 1;
        $len = 1;
        for ($i = 1; $i < count($nums); $i++) {
            $len = $nums[$i] > $nums[$i - 1] ? $len + 1 : 1;
            $res = max($res, $len);
        }
        $len = 1;
        for ($i = 1; $i < count($nums); $i++) {
            $len = $nums[$i] < $nums[$i - 1] ? $len + 1 : 1;
            $res = max($res, $len);
        }
        return $res;
    }
}
*/

class Solution {
    function longestMonotonicSubarray($nums) {
        $res = 1;
        $inc = 1;
        $dec = 1;
        for ($i = 1; $i < count($nums); $i++) {
            $inc = $nums[$i] > $nums[$i - 1] ? $inc + 1 : 1;
            $dec = $nums[$i] < $nums[$i - 1] ? $dec + 1 : 1;
            $res = max($res, $inc, $dec);
        }
        return $res;
    }
}