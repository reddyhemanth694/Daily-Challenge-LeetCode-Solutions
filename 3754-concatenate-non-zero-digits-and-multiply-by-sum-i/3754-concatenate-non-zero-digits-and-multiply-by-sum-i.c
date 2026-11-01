/*
Brute Force

long long sumAndMultiply(int n) {
    char s[16], t[16];
    sprintf(s, "%d", n);
    int k = 0;
    for (int i = 0; s[i]; i++)
        if (s[i] != '0') t[k++] = s[i];
    t[k] = '\0';
    if (k == 0) return 0;
    long long x = atoll(t), sum = 0;
    for (int i = 0; i < k; i++) sum += t[i] - '0';
    return x * sum;
}
*/

/*
Better Approach

long long sumAndMultiply(int n) {
    int digits[12], k = 0;
    for (; n > 0; n /= 10) digits[k++] = n % 10;
    long long x = 0, sum = 0;
    for (int i = k - 1; i >= 0; i--) {
        if (digits[i] != 0) {
            x = x * 10 + digits[i];
            sum += digits[i];
        }
    }
    return x * sum;
}
*/

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