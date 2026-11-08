/*
Brute Force
int countServers(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0], ans = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                int found = 0;
                for (int k = 0; k < n; k++)
                    if (k != j && grid[i][k] == 1) found = 1;
                for (int k = 0; k < m; k++)
                    if (k != i && grid[k][j] == 1) found = 1;
                if (found) ans++;
            }
        }
    }
    return ans;
}
*/

/*
Better Approach
int countServers(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int row[250] = {0}, col[250] = {0};
    for (int i = 0; i < m; i++)
        for (int j = 0; j < n; j++)
            if (grid[i][j] == 1) { row[i]++; col[j]++; }
    int ans = 0;
    for (int i = 0; i < m; i++)
        for (int j = 0; j < n; j++)
            if (grid[i][j] == 1 && (row[i] > 1 || col[j] > 1)) ans++;
    return ans;
}
*/

// Optimized Approach: one pass, answer = total - isolated
int countServers(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0], total = 0;
    int rowCnt[250] = {0}, rowCol[250] = {0}, colCnt[250] = {0};
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                rowCnt[i]++;
                rowCol[i] += j;
                colCnt[j]++;
                total++;
            }
        }
    }
    int isolated = 0;
    for (int i = 0; i < m; i++)
        if (rowCnt[i] == 1 && colCnt[rowCol[i]] == 1) isolated++;
    return total - isolated;
}