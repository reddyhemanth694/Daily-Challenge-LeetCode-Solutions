/*
Brute Force

function countNonDecreasingSubarrays(nums: number[], k: number): number {
    const n = nums.length;
    let ans = 0;
    for (let l = 0; l < n; l++) {
        let mx = 0, cost = 0;
        for (let r = l; r < n; r++) {
            mx = Math.max(mx, nums[r]);
            cost += mx - nums[r];
            if (cost > k) break;
            ans++;
        }
    }
    return ans;
}
*/

/*
Better Approach

function countNonDecreasingSubarrays(nums: number[], k: number): number {
    const n = nums.length;
    let lg = 1;
    while ((1 << lg) <= n) lg++;
    const pre = new Float64Array(n + 1);
    for (let i = 0; i < n; i++) pre[i + 1] = pre[i] + nums[i];
    const up: Int32Array[] = [new Int32Array(n + 1).fill(n)], sum: Float64Array[] = [new Float64Array(n + 1)];
    const st: number[] = [];
    for (let i = n - 1; i >= 0; i--) {
        while (st.length && nums[st[st.length - 1]] <= nums[i]) st.pop();
        const nx = st.length ? st[st.length - 1] : n;
        st.push(i);
        up[0][i] = nx;
        sum[0][i] = nums[i] * (nx - i) - (pre[nx] - pre[i]);
    }
    for (let j = 1; j < lg; j++) {
        const pu = up[j - 1], ps = sum[j - 1];
        const cu = new Int32Array(n + 1), cs = new Float64Array(n + 1);
        for (let i = 0; i <= n; i++) {
            cu[i] = pu[pu[i]];
            cs[i] = ps[i] + ps[pu[i]];
        }
        up.push(cu);
        sum.push(cs);
    }
    let ans = 0;
    for (let l = 0; l < n; l++) {
        let cur = l, acc = 0;
        for (let j = lg - 1; j >= 0; j--) {
            if (cur < n && acc + sum[j][cur] <= k) {
                acc += sum[j][cur];
                cur = up[j][cur];
            }
        }
        if (cur === n) {
            ans += n - l;
            continue;
        }
        let lo = cur, hi = up[0][cur] - 1;
        while (lo < hi) {
            const mid = (lo + hi + 1) >> 1;
            if (acc + nums[cur] * (mid - cur + 1) - (pre[mid + 1] - pre[cur]) <= k) lo = mid;
            else hi = mid - 1;
        }
        ans += lo - l + 1;
    }
    return ans;
}
*/

function countNonDecreasingSubarrays(nums: number[], k: number): number {
    const n = nums.length;
    const dq = new Int32Array(n);
    let head = n, tail = n, r = n - 1, ans = 0, cost = 0;
    for (let l = n - 1; l >= 0; l--) {
        while (head < tail && nums[dq[head]] <= nums[l]) {
            const i = dq[head++];
            const end = head < tail ? dq[head] : r + 1;
            cost += (nums[l] - nums[i]) * (end - i);
        }
        dq[--head] = l;
        while (cost > k) {
            cost -= nums[dq[tail - 1]] - nums[r];
            if (dq[tail - 1] === r) tail--;
            r--;
        }
        ans += r - l + 1;
    }
    return ans;
}