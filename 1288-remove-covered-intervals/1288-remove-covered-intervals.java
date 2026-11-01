class Solution {
    public int removeCoveredIntervals(int[][] intervals) {
        Arrays.sort(intervals, (a, b) -> a[0] != b[0] ? a[0] - b[0] : b[1] - a[1]);
        int res = 0, end = 0;
        for (int[] it : intervals) {
            if (it[1] > end) {
                res++;
                end = it[1];
            }
        }
        return res;
    }
}