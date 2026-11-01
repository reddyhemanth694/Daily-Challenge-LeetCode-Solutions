/*
Brute Force

class Solution {
public:
    long long sumAndMultiply(int n) {
        string s = to_string(n), t;
        for (char c : s)
            if (c != '0') t += c;
        if (t.empty()) return 0;
        long long x = stoll(t), sum = 0;
        for (char c : t) sum += c - '0';
        return x * sum;
    }
};
*/

/*
Better Approach

class Solution {
public:
    long long sumAndMultiply(int n) {
        vector<int> digits;
        for (; n > 0; n /= 10) digits.push_back(n % 10);
        long long x = 0, sum = 0;
        for (int i = (int)digits.size() - 1; i >= 0; i--) {
            if (digits[i] != 0) {
                x = x * 10 + digits[i];
                sum += digits[i];
            }
        }
        return x * sum;
    }
};
*/

class Solution {
public:
    long long sumAndMultiply(int n) {
        long long x = 0, sum = 0, p = 1;
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
};