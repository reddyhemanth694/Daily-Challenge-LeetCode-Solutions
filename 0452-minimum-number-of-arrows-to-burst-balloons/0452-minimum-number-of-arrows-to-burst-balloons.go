import "sort"

func findMinArrowShots(points [][]int) int {
    sort.Slice(points, func(i, j int) bool {
        return points[i][1] < points[j][1]
    })

    arrows := 1
    arrow := points[0][1]

    for i := 1; i < len(points); i++ {
        if points[i][0] > arrow {
            arrows++
            arrow = points[i][1]
        }
    }

    return arrows
}