/*
Brute Force

class Solution {
    function findTheDistanceValue($arr1, $arr2, $d) {
        $ans = 0;
        foreach ($arr1 as $a) {
            $ok = true;
            foreach ($arr2 as $b) {
                if (abs($a - $b) <= $d) {
                    $ok = false;
                    break;
                }
            }
            if ($ok) $ans++;
        }
        return $ans;
    }
}
*/

/*
Better Approach

class Solution {
    function findTheDistanceValue($arr1, $arr2, $d) {
        sort($arr2);
        $m = count($arr2);
        $ans = 0;
        foreach ($arr1 as $a) {
            $lo = 0;
            $hi = $m;
            while ($lo < $hi) {
                $mid = intdiv($lo + $hi, 2);
                if ($arr2[$mid] < $a - $d) $lo = $mid + 1;
                else $hi = $mid;
            }
            if ($lo == $m || $arr2[$lo] > $a + $d) $ans++;
        }
        return $ans;
    }
}
*/

class Solution {
    function findTheDistanceValue($arr1, $arr2, $d) {
        $pre = array_fill(0, 2202, 0);
        foreach ($arr2 as $v) $pre[$v + 1101]++;
        for ($i = 1; $i < 2202; $i++) $pre[$i] += $pre[$i - 1];
        $ans = 0;
        foreach ($arr1 as $a)
            if ($pre[$a + $d + 1101] == $pre[$a - $d + 1100]) $ans++;
        return $ans;
    }
}