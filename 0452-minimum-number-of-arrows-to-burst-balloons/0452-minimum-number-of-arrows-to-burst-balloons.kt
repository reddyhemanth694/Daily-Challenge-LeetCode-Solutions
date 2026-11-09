class Solution {
    fun findMinArrowShots(points: Array<IntArray>): Int {
        points.sortWith(compareBy { it[1] })

        var arrows = 1
        var arrow = points[0][1]

        for (i in 1 until points.size) {
            if (points[i][0] > arrow) {
                arrows++
                arrow = points[i][1]
            }
        }

        return arrows
    }
}