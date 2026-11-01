/*
Brute Force

class Solution {
    func sumAndMultiply(_ n: Int) -> Int {
        let t = String(n).filter { $0 != "0" }
        if t.isEmpty { return 0 }
        return Int(t)! * t.reduce(0) { $0 + $1.wholeNumberValue! }
    }
}
*/

/*
Better Approach

class Solution {
    func sumAndMultiply(_ n: Int) -> Int {
        var digits = [Int]()
        var m = n
        while m > 0 {
            digits.append(m % 10)
            m /= 10
        }
        var x = 0, sum = 0
        for d in digits.reversed() where d != 0 {
            x = x * 10 + d
            sum += d
        }
        return x * sum
    }
}
*/

class Solution {
    func sumAndMultiply(_ n: Int) -> Int {
        var m = n, x = 0, sum = 0, p = 1
        while m > 0 {
            let d = m % 10
            if d != 0 {
                x += d * p
                sum += d
                p *= 10
            }
            m /= 10
        }
        return x * sum
    }
}