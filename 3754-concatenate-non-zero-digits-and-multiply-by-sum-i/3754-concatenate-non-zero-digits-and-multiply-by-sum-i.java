/*
Brute Force

class Solution {
    public long sumAndMultiply(int n) {
        String t = String.valueOf(n).replace("0", "");
        if (t.isEmpty()) return 0;
        long x = Long.parseLong(t), sum = 0;
        for (char c : t.toCharArray()) sum += c - '0';
        return x * sum;
    }
}
*/

/*
Better Approach

class Solution {
    public long sumAndMultiply(int n) {
        List<Integer> digits = new ArrayList<>();
        for (; n > 0; n /= 10) digits.add(n % 10);
        long x = 0, sum = 0;
        for (int i = digits.size() - 1; i >= 0; i--) {
            int d = digits.get(i);
            if (d != 0) {
                x = x * 10 + d;
                sum += d;
            }
        }
        return x * sum;
    }
}
*/

class Solution {
    public long sumAndMultiply(int n) {
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