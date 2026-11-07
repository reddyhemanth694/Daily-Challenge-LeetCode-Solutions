/*
Brute Force
class Solution {
public:
    int countServers(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size(), ans = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    bool found = false;
                    for (int k = 0; k < n; k++)
                        if (k != j && grid[i][k] == 1) found = true;
                    for (int k = 0; k < m; k++)
                        if (k != i && grid[k][j] == 1) found = true;
                    if (found) ans++;
                }
            }
        }
        return ans;
    }
};
*/

/*
Better Approach
class Solution {
public:
    int countServers(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<int> row(m, 0), col(n, 0);
        for (int i = 0; i < m; i++)
            for (int j = 0; j < n; j++)
                if (grid[i][j] == 1) { row[i]++; col[j]++; }
        int ans = 0;
        for (int i = 0; i < m; i++)
            for (int j = 0; j < n; j++)
                if (grid[i][j] == 1 && (row[i] > 1 || col[j] > 1)) ans++;
        return ans;
    }
};
*/

// Optimized Approach: one pass, answer = total - isolated
class Solution {
public:
    int countServers(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size(), total = 0;
        vector<int> rowCnt(m, 0), rowCol(m, 0), colCnt(n, 0);
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
};