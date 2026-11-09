class Solution:
    def findMinArrowShots(self, points):
        points.sort(key=lambda x: x[1])

        arrows = 1
        arrow = points[0][1]

        for i in range(1, len(points)):
            if points[i][0] > arrow:
                arrows += 1
                arrow = points[i][1]

        return arrows