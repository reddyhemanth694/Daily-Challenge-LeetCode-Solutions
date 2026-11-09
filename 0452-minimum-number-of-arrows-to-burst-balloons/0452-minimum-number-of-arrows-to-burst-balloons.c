#include <stdlib.h>

int compare(const void* a, const void* b) {
    int* x = *(int**)a;
    int* y = *(int**)b;

    if (x[1] < y[1]) return -1;
    if (x[1] > y[1]) return 1;
    return 0;
}

int findMinArrowShots(int** points, int pointsSize, int* pointsColSize) {
    qsort(points, pointsSize, sizeof(int*), compare);

    int arrows = 1;
    int arrow = points[0][1];

    for (int i = 1; i < pointsSize; i++) {
        if (points[i][0] > arrow) {
            arrows++;
            arrow = points[i][1];
        }
    }

    return arrows;
}