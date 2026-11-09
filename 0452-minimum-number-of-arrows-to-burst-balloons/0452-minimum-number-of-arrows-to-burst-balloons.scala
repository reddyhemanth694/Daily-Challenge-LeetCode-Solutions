object Solution {
    def findMinArrowShots(points: Array[Array[Int]]): Int = {
        val sortedPoints = points.sortBy(_(1))

        var arrows = 1
        var arrow = sortedPoints(0)(1)

        for (i <- 1 until sortedPoints.length) {
            if (sortedPoints(i)(0) > arrow) {
                arrows += 1
                arrow = sortedPoints(i)(1)
            }
        }

        arrows
    }
}