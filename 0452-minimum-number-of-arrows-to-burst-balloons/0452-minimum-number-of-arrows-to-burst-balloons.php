class Solution {
    function findMinArrowShots($points) {
        usort($points, function($a, $b) {
            return $a[1] <=> $b[1];
        });

        $arrows = 1;
        $arrow = $points[0][1];

        for ($i = 1; $i < count($points); $i++) {
            if ($points[$i][0] > $arrow) {
                $arrows++;
                $arrow = $points[$i][1];
            }
        }

        return $arrows;
    }
}