/*
Brute Force

class Solution {
    function minMoves($nums) {
        $n = count($nums);
        $moves = 0;
        while (true) {
            $mx = 0;
            $same = true;
            for ($i = 1; $i < $n; $i++) {
                if ($nums[$i] != $nums[0]) $same = false;
                if ($nums[$i] > $nums[$mx]) $mx = $i;
            }
            if ($same) return $moves;
            for ($i = 0; $i < $n; $i++)
                if ($i != $mx) $nums[$i]++;
            $moves++;
        }
    }
}
*/

/*
Better Approach

class Solution {
    function minMoves($nums) {
        sort($nums);
        $moves = 0;
        foreach ($nums as $x) $moves += $x - $nums[0];
        return $moves;
    }
}
*/

class Solution {
    function minMoves($nums) {
        $mn = min($nums);
        $moves = 0;
        foreach ($nums as $x) $moves += $x - $mn;
        return $moves;
    }
}