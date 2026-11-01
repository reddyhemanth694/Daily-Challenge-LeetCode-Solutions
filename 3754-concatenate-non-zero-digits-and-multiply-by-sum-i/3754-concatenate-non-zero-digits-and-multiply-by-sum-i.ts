/*
Brute Force

function sumAndMultiply(n: number): number {
    const t = String(n).split("0").join("");
    if (t.length === 0) return 0;
    let sum = 0;
    for (const c of t) sum += Number(c);
    return Number(t) * sum;
}
*/

/*
Better Approach

function sumAndMultiply(n: number): number {
    const digits: number[] = [];
    for (; n > 0; n = Math.floor(n / 10)) digits.push(n % 10);
    let x = 0, sum = 0;
    for (let i = digits.length - 1; i >= 0; i--) {
        if (digits[i] !== 0) {
            x = x * 10 + digits[i];
            sum += digits[i];
        }
    }
    return x * sum;
}
*/

function sumAndMultiply(n: number): number {
    let x = 0, sum = 0, p = 1;
    for (; n > 0; n = Math.floor(n / 10)) {
        const d = n % 10;
        if (d !== 0) {
            x += d * p;
            sum += d;
            p *= 10;
        }
    }
    return x * sum;
}