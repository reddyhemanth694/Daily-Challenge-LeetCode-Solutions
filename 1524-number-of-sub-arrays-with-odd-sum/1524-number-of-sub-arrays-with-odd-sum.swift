/*
Brute Force

class Solution {
    func numOfSubarrays(_ arr: [Int]) -> Int {
        let mod = 1_000_000_007
        let n = arr.count
        var ans = 0
        for i in 0..<n {
            for j in i..<n {
                var sum = 0
                for k in i...j { sum += arr[k] }
                if sum % 2 == 1 { ans = (ans + 1) % mod }
            }
        }
        return ans
    }
}
*/

/*
Better Approach

class Solution {
    func numOfSubarrays(_ arr: [Int]) -> Int {
        let mod = 1_000_000_007
        let n = arr.count
        var ans = 0
        for i in 0..<n {
            var sum = 0
            for j in i..<n {
                sum += arr[j]
                if sum % 2 == 1 { ans = (ans + 1) % mod }
            }
        }
        return ans
    }
}
*/

class Solution {
    func numOfSubarrays(_ arr: [Int]) -> Int {
        let mod = 1_000_000_007
        var odd = 0, even = 1, sum = 0, ans = 0
        for x in arr {
            sum += x
            if sum % 2 == 1 {
                ans = (ans + even) % mod
                odd += 1
            } else {
                ans = (ans + odd) % mod
                even += 1
            }
        }
        return ans
    }
}