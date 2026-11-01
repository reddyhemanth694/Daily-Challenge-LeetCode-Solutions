/*
Brute Force

public class Solution {
    public long SumAndMultiply(int n) {
        string t = n.ToString().Replace("0", "");
        if (t.Length == 0) return 0;
        long sum = 0;
        foreach (char c in t) sum += c - '0';
        return long.Parse(t) * sum;
    }
}
*/

/*
Better Approach

public class Solution {
    public long SumAndMultiply(int n) {
        List<int> digits = new List<int>();
        for (; n > 0; n /= 10) digits.Add(n % 10);
        long x = 0, sum = 0;
        for (int i = digits.Count - 1; i >= 0; i--) {
            if (digits[i] != 0) {
                x = x * 10 + digits[i];
                sum += digits[i];
            }
        }
        return x * sum;
    }
}
*/

public class Solution {
    public long SumAndMultiply(int n) {
        long x = 0, sum = 0, p = 1;
        for (; n > 0; n /= 10) {
            int d = n % 10;
            if (d != 0) {
                x += d * p;
                sum += d;
                p *= 10;
            }
        }
        return x * sum;
    }
}