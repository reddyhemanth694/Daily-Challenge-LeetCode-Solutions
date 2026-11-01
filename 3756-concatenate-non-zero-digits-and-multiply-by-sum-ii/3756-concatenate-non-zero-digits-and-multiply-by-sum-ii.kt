/*
Brute Force

class Solution {
    fun sumAndMultiply(s: String, queries: Array<IntArray>): IntArray {
        val mod = 1_000_000_007L
        return IntArray(queries.size) { k ->
            var x = 0L
            var sum = 0L
            for (i in queries[k][0]..queries[k][1]) {
                val d = s[i] - '0'
                if (d != 0) {
                    x = (x * 10 + d) % mod
                    sum += d
                }
            }
            (x * sum % mod).toInt()
        }
    }
}
*/

/*
Better Approach

class Solution {
    val mod = 1_000_000_007L

    fun power(base: Long, exp: Int): Long {
        var b = base
        var e = exp
        var r = 1L
        while (e > 0) {
            if (e and 1 == 1) r = r * b % mod
            b = b * b % mod
            e = e shr 1
        }
        return r
    }

    fun sumAndMultiply(s: String, queries: Array<IntArray>): IntArray {
        val m = s.length
        val pre = LongArray(m + 1)
        val cnt = IntArray(m + 1)
        val sum = LongArray(m + 1)
        for (i in 0 until m) {
            val d = s[i] - '0'
            pre[i + 1] = if (d != 0) (pre[i] * 10 + d) % mod else pre[i]
            cnt[i + 1] = cnt[i] + if (d != 0) 1 else 0
            sum[i + 1] = sum[i] + d
        }
        return IntArray(queries.size) { k ->
            val l = queries[k][0]
            val r = queries[k][1] + 1
            val x = ((pre[r] - pre[l] * power(10, cnt[r] - cnt[l])) % mod + mod) % mod
            (x * (sum[r] - sum[l]) % mod).toInt()
        }
    }
}
*/

class Solution {
    fun sumAndMultiply(s: String, queries: Array<IntArray>): IntArray {
        val mod = 1_000_000_007L
        val m = s.length
        val pre = LongArray(m + 1)
        val pw = LongArray(m + 1)
        val cnt = IntArray(m + 1)
        val sum = LongArray(m + 1)
        pw[0] = 1
        for (i in 0 until m) {
            val d = s[i] - '0'
            pw[i + 1] = pw[i] * 10 % mod
            pre[i + 1] = if (d != 0) (pre[i] * 10 + d) % mod else pre[i]
            cnt[i + 1] = cnt[i] + if (d != 0) 1 else 0
            sum[i + 1] = sum[i] + d
        }
        return IntArray(queries.size) { k ->
            val l = queries[k][0]
            val r = queries[k][1] + 1
            val x = ((pre[r] - pre[l] * pw[cnt[r] - cnt[l]]) % mod + mod) % mod
            (x * (sum[r] - sum[l]) % mod).toInt()
        }
    }
}