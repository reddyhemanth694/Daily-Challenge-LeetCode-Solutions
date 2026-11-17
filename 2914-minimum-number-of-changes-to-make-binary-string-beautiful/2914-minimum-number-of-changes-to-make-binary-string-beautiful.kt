/*
Brute Force

class Solution {
    fun solve(s: String, i: Int): Int {
        val n = s.length
        if (i == n) return 0
        var best = n
        var ones = 0
        for (j in i until n) {
            if (s[j] == '1') ones++
            val len = j - i + 1
            if (len % 2 == 0) best = minOf(best, minOf(ones, len - ones) + solve(s, j + 1))
        }
        return best
    }

    fun minChanges(s: String): Int = solve(s, 0)
}
*/

/*
Better Approach

class Solution {
    fun minChanges(s: String): Int {
        val n = s.length
        val dp = IntArray(n + 1) { n }
        dp[0] = 0
        for (i in 0 until n step 2) {
            var ones = 0
            for (j in i until n) {
                if (s[j] == '1') ones++
                val len = j - i + 1
                if (len % 2 == 0) dp[j + 1] = minOf(dp[j + 1], dp[i] + minOf(ones, len - ones))
            }
        }
        return dp[n]
    }
}
*/

class Solution {
    fun minChanges(s: String): Int {
        var ans = 0
        for (i in 0 until s.length step 2) {
            if (s[i] != s[i + 1]) ans++
        }
        return ans
    }
}