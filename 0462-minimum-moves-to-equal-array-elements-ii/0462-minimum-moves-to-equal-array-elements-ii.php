/*
Brute Force

class Solution {
    function minMoves2($nums) {
        $best = PHP_INT_MAX;
        foreach ($nums as $x) {
            $cost = 0;
            foreach ($nums as $a) $cost += abs($a - $x);
            $best = min($best, $cost);
        }
        return $best;
    }
}
*/

/*
Better Approach

class Solution {
    function minMoves2($nums) {
        sort($nums);
        $median = $nums[intdiv(count($nums), 2)];
        $moves = 0;
        foreach ($nums as $a) $moves += abs($a - $median);
        return $moves;
    }
}
*/

class Solution {
    function minMoves2($nums) {
        $k = intdiv(count($nums), 2);
        $lo = 0;
        $hi = count($nums) - 1;
        $median = 0;
        while (true) {
            $pivot = $nums[random_int($lo, $hi)];
            $lt = $lo;
            $i = $lo;
            $gt = $hi;
            while ($i <= $gt) {
                if ($nums[$i] < $pivot) {
                    [$nums[$lt], $nums[$i]] = [$nums[$i], $nums[$lt]];
                    $lt++;
                    $i++;
                } elseif ($nums[$i] > $pivot) {
                    [$nums[$i], $nums[$gt]] = [$nums[$gt], $nums[$i]];
                    $gt--;
                } else {
                    $i++;
                }
            }
            if ($k < $lt) $hi = $lt - 1;
            elseif ($k > $gt) $lo = $gt + 1;
            else {
                $median = $pivot;
                break;
            }
        }
        $moves = 0;
        foreach ($nums as $a) $moves += abs($a - $median);
        return $moves;
    }
}