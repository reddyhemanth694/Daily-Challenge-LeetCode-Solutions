/*
Brute Force

var minOperations = function(nums, x, k) {
    const n = nums.length;
    const windowCost = (i) => {
        const w = nums.slice(i, i + x).sort((a, b) => a - b);
        const med = w[x >> 1];
        let cost = 0;
        for (const v of w) cost += Math.abs(v - med);
        return cost;
    };
    const dfs = (i, j) => {
        if (j === 0) return 0;
        if (n - i < j * x) return Infinity;
        return Math.min(dfs(i + 1, j), windowCost(i) + dfs(i + x, j - 1));
    };
    return dfs(0, k);
};
*/

/*
Better Approach

var minOperations = function(nums, x, k) {
    const n = nums.length;
    const cost = new Float64Array(n - x + 1);
    for (let i = 0; i + x <= n; i++) {
        const w = nums.slice(i, i + x).sort((a, b) => a - b);
        const med = w[x >> 1];
        for (const v of w) cost[i] += Math.abs(v - med);
    }
    let prev = new Float64Array(n + 1), cur = new Float64Array(n + 1);
    for (let j = 1; j <= k; j++) {
        cur.fill(Infinity);
        for (let i = x; i <= n; i++) cur[i] = Math.min(cur[i - 1], prev[i - x] + cost[i - x]);
        [prev, cur] = [cur, prev];
    }
    return prev[n];
};
*/

var minOperations = function(nums, x, k) {
    const n = nums.length;
    const vals = [...new Set(nums)].sort((a, b) => a - b);
    const m = vals.length;
    const pos = new Map();
    vals.forEach((v, i) => pos.set(v, i + 1));
    const idx = nums.map(v => pos.get(v));
    let top = 1;
    while (top * 2 <= m) top *= 2;
    const cnt = new Int32Array(m + 1), sum = new Float64Array(m + 1), cost = new Float64Array(n - x + 1);
    const update = (i, d) => {
        for (let p = idx[i]; p <= m; p += p & -p) {
            cnt[p] += d;
            sum[p] += d * nums[i];
        }
    };
    let total = 0;
    const half = (x + 1) >> 1;
    for (let i = 0; i < n; i++) {
        update(i, 1);
        total += nums[i];
        if (i >= x) {
            update(i - x, -1);
            total -= nums[i - x];
        }
        if (i >= x - 1) {
            let p = 0, need = half, lowCnt = 0, lowSum = 0;
            for (let step = top; step > 0; step >>= 1) {
                if (p + step <= m && cnt[p + step] < need) {
                    p += step;
                    need -= cnt[p];
                    lowCnt += cnt[p];
                    lowSum += sum[p];
                }
            }
            const med = vals[p];
            cost[i - x + 1] = med * lowCnt - lowSum + (total - lowSum) - med * (x - lowCnt);
        }
    }
    let prev = new Float64Array(n + 1), cur = new Float64Array(n + 1);
    for (let j = 1; j <= k; j++) {
        cur.fill(Infinity);
        for (let i = x; i <= n; i++) cur[i] = Math.min(cur[i - 1], prev[i - x] + cost[i - x]);
        [prev, cur] = [cur, prev];
    }
    return prev[n];
};