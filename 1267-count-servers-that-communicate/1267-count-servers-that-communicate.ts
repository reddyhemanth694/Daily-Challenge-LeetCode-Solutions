/*
Brute Force
function countServers(grid: number[][]): number {
    const m = grid.length, n = grid[0].length;
    let ans = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                let found = false;
                for (let k = 0; k < n; k++)
                    if (k !== j && grid[i][k] === 1) found = true;
                for (let k = 0; k < m; k++)
                    if (k !== i && grid[k][j] === 1) found = true;
                if (found) ans++;
            }
        }
    }
    return ans;
}
*/

/*
Better Approach
function countServers(grid: number[][]): number {
    const m = grid.length, n = grid[0].length;
    const row: number[] = new Array(m).fill(0);
    const col: number[] = new Array(n).fill(0);
    for (let i = 0; i < m; i++)
        for (let j = 0; j < n; j++)
            if (grid[i][j] === 1) { row[i]++; col[j]++; }
    let ans = 0;
    for (let i = 0; i < m; i++)
        for (let j = 0; j < n; j++)
            if (grid[i][j] === 1 && (row[i] > 1 || col[j] > 1)) ans++;
    return ans;
}
*/

// Optimized Approach: one pass, answer = total - isolated
function countServers(grid: number[][]): number {
    const m = grid.length, n = grid[0].length;
    const rowCnt: number[] = new Array(m).fill(0);
    const rowCol: number[] = new Array(m).fill(0);
    const colCnt: number[] = new Array(n).fill(0);
    let total = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                rowCnt[i]++;
                rowCol[i] += j;
                colCnt[j]++;
                total++;
            }
        }
    }
    let isolated = 0;
    for (let i = 0; i < m; i++)
        if (rowCnt[i] === 1 && colCnt[rowCol[i]] === 1) isolated++;
    return total - isolated;
}