/*
Brute Force

class Solution {
    fun sumAndMultiply(n: Int): Long {
        val t = n.toString().replace("0", "")
        if (t.isEmpty()) return 0
        return t.toLong() * t.sumOf { it - '0' }
    }
}
*/

/*
Better Approach

class Solution {
    fun sumAndMultiply(n: Int): Long {
        val digits = mutableListOf<Int>()
        var m = n
        while (m > 0) {
            digits.add(m % 10)
            m /= 10
        }
        var x = 0L
        var sum = 0L
        for (d in digits.asReversed()) {
            if (d != 0) {
                x = x * 10 + d
                sum += d
            }
        }
        return x * sum
    }
}
*/

class Solution {
    fun sumAndMultiply(n: Int): Long {
        var m = n
        var x = 0L
        var sum = 0L
        var p = 1L
        while (m > 0) {
            val d = m % 10
            if (d != 0) {
                x += d * p
                sum += d
                p *= 10
            }
            m /= 10
        }
        return x * sum
    }
}