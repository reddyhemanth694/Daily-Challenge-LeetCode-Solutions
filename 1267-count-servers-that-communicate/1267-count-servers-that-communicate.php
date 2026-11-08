/*
Brute Force
class Solution {
    function countServers($grid) {
        $m = count($grid);
        $n = count($grid[0]);
        $ans = 0;
        for ($i = 0; $i < $m; $i++) {
            for ($j = 0; $j < $n; $j++) {
                if ($grid[$i][$j] == 1) {
                    $found = false;
                    for ($k = 0; $k < $n; $k++)
                        if ($k != $j && $grid[$i][$k] == 1) $found = true;
                    for ($k = 0; $k < $m; $k++)
                        if ($k != $i && $grid[$k][$j] == 1) $found = true;
                    if ($found) $ans++;
                }
            }
        }
        return $ans;
    }
}
*/

/*
Better Approach
class Solution {
    function countServers($grid) {
        $m = count($grid);
        $n = count($grid[0]);
        $row = array_fill(0, $m, 0);
        $col = array_fill(0, $n, 0);
        for ($i = 0; $i < $m; $i++)
            for ($j = 0; $j < $n; $j++)
                if ($grid[$i][$j] == 1) { $row[$i]++; $col[$j]++; }
        $ans = 0;
        for ($i = 0; $i < $m; $i++)
            for ($j = 0; $j < $n; $j++)
                if ($grid[$i][$j] == 1 && ($row[$i] > 1 || $col[$j] > 1)) $ans++;
        return $ans;
    }
}
*/

// Optimized Approach: one pass, answer = total - isolated
class Solution {
    /**
     * @param Integer[][] $grid
     * @return Integer
     */
    function countServers($grid) {
        $m = count($grid);
        $n = count($grid[0]);
        $rowCnt = array_fill(0, $m, 0);
        $rowCol = array_fill(0, $m, 0);
        $colCnt = array_fill(0, $n, 0);
        $total = 0;
        for ($i = 0; $i < $m; $i++) {
            for ($j = 0; $j < $n; $j++) {
                if ($grid[$i][$j] == 1) {
                    $rowCnt[$i]++;
                    $rowCol[$i] += $j;
                    $colCnt[$j]++;
                    $total++;
                }
            }
        }
        $isolated = 0;
        for ($i = 0; $i < $m; $i++) {
            if ($rowCnt[$i] == 1 && $colCnt[$rowCol[$i]] == 1) $isolated++;
        }
        return $total - $isolated;
    }
}