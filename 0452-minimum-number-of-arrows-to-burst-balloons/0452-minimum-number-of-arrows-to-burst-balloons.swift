class Solution {
    func findMinArrowShots(_ points: [[Int]]) -> Int {
        let sortedPoints = points.sorted {
            $0[1] < $1[1]
        }

        var arrows = 1
        var arrow = sortedPoints[0][1]

        for i in 1..<sortedPoints.count {
            if sortedPoints[i][0] > arrow {
                arrows += 1
                arrow = sortedPoints[i][1]
            }
        }

        return arrows
    }
}