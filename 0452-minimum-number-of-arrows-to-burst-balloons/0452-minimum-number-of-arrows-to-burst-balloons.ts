function findMinArrowShots(points: number[][]): number {
    points.sort((a, b) => a[1] - b[1]);

    let arrows = 1;
    let arrow = points[0][1];

    for (let i = 1; i < points.length; i++) {
        if (points[i][0] > arrow) {
            arrows++;
            arrow = points[i][1];
        }
    }

    return arrows;
}