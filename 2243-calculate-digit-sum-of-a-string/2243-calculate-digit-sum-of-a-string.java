/*
Brute Force

class Solution {
    public String digitSum(String s, int k) {
        String cur = s;
        while (cur.length() > k) {
            String next = "";
            for (int i = 0; i < cur.length(); i += k) {
                int end = Math.min(i + k, cur.length());
                String group = cur.substring(i, end);
                int sum = 0;
                for (char c : group.toCharArray()) {
                    sum += c - '0';
                }
                next = next + sum;
            }
            cur = next;
        }
        return cur;
    }
}
*/

/*
Better Approach

class Solution {
    public String digitSum(String s, int k) {
        String cur = s;
        while (cur.length() > k) {
            StringBuilder sb = new StringBuilder();
            int sum = 0, cnt = 0;
            for (int i = 0; i < cur.length(); i++) {
                sum += cur.charAt(i) - '0';
                cnt++;
                if (cnt == k) {
                    sb.append(sum);
                    sum = 0;
                    cnt = 0;
                }
            }
            if (cnt > 0) {
                sb.append(sum);
            }
            cur = sb.toString();
        }
        return cur;
    }
}
*/

class Solution {
    public String digitSum(String s, int k) {
        char[] d = s.toCharArray();
        int len = d.length;
        while (len > k) {
            int w = 0;
            for (int i = 0; i < len; ) {
                int end = Math.min(i + k, len);
                int sum = 0;
                for (int j = i; j < end; j++) {
                    sum += d[j] - '0';
                }
                if (sum >= 100) {
                    d[w++] = (char) ('0' + sum / 100);
                }
                if (sum >= 10) {
                    d[w++] = (char) ('0' + (sum / 10) % 10);
                }
                d[w++] = (char) ('0' + sum % 10);
                i = end;
            }
            len = w;
        }
        return new String(d, 0, len);
    }
}