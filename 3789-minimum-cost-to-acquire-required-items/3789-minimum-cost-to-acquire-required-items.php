/*
Brute Force

class Solution {
    function minimumCost($cost1, $cost2, $costBoth, $need1, $need2) {
        $best = PHP_INT_MAX;
        for ($k = 0; $k <= max($need1, $need2); $k++)
            $best = min($best, $k * $costBoth + max(0, $need1 - $k) * $cost1 + max(0, $need2 - $k) * $cost2);
        return $best;
    }
}
*/

/*
Better Approach

class Solution {
    function minimumCost($cost1, $cost2, $costBoth, $need1, $need2) {
        $total = fn($k) => $k * $costBoth + max(0, $need1 - $k) * $cost1 + max(0, $need2 - $k) * $cost2;
        $lo = 0;
        $hi = max($need1, $need2);
        while ($lo < $hi) {
            $mid = intdiv($lo + $hi, 2);
            if ($total($mid) <= $total($mid + 1)) $hi = $mid;
            else $lo = $mid + 1;
        }
        return $total($lo);
    }
}
*/

class Solution {
    function minimumCost($cost1, $cost2, $costBoth, $need1, $need2) {
        $both = min($need1, $need2);
        return $both * min($costBoth, $cost1 + $cost2) + ($need1 - $both) * min($cost1, $costBoth) + ($need2 - $both) * min($cost2, $costBoth);
    }
}