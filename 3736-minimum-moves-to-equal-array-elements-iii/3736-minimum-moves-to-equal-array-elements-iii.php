/*
Brute Force

class Solution {
    function minMoves($nums) {
        $moves = 0;
        while (min($nums) != max($nums)) {
            $nums[array_search(min($nums), $nums)]++;
            $moves++;
        }
        return $moves;
    }
}
*/

/*
Better Approach

class Solution {
    function minMoves($nums) {
        sort($nums);
        $last = $nums[count($nums) - 1];
        $moves = 0;
        foreach ($nums as $x) $moves += $last - $x;
        return $moves;
    }
}
*/

class Solution {
    function minMoves($nums) {
        $mx = 0;
        $sum = 0;
        foreach ($nums as $x) {
            $mx = max($mx, $x);
            $sum += $x;
        }
        return $mx * count($nums) - $sum;
    }
}