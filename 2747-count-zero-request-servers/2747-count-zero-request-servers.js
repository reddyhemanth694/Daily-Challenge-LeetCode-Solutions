/*
Brute Force

var countServers = function(n, logs, x, queries) {
    return queries.map(q => {
        const seen = new Set();
        for (const [s, t] of logs)
            if (t >= q - x && t <= q) seen.add(s);
        return n - seen.size;
    });
};
*/

/*
Better Approach

var countServers = function(n, logs, x, queries) {
    logs.sort((a, b) => a[1] - b[1]);
    const m = logs.length;
    const stamp = new Int32Array(n + 1).fill(-1);
    return queries.map((q, i) => {
        let lo = 0, hi = m;
        while (lo < hi) {
            const mid = (lo + hi) >> 1;
            if (logs[mid][1] < q - x) lo = mid + 1;
            else hi = mid;
        }
        let cnt = 0;
        for (let j = lo; j < m && logs[j][1] <= q; j++) {
            if (stamp[logs[j][0]] !== i) {
                stamp[logs[j][0]] = i;
                cnt++;
            }
        }
        return n - cnt;
    });
};
*/

var countServers = function(n, logs, x, queries) {
    logs.sort((a, b) => a[1] - b[1]);
    const m = logs.length, k = queries.length;
    const idx = Array.from({ length: k }, (_, i) => i).sort((a, b) => queries[a] - queries[b]);
    const cnt = new Int32Array(n + 1);
    const ans = new Array(k);
    let l = 0, r = 0, distinct = 0;
    for (const i of idx) {
        const q = queries[i];
        while (r < m && logs[r][1] <= q)
            if (cnt[logs[r++][0]]++ === 0) distinct++;
        while (l < r && logs[l][1] < q - x)
            if (--cnt[logs[l++][0]] === 0) distinct--;
        ans[i] = n - distinct;
    }
    return ans;
};