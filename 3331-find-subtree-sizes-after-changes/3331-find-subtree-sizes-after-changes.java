class Solution {
    public int[] findSubtreeSizes(int[] parent, String s) {
        int n = parent.length;
        List<Integer>[] ch = new ArrayList[n];
        for (int i = 0; i < n; i++) ch[i] = new ArrayList<>();
        for (int i = 1; i < n; i++) ch[parent[i]].add(i);
        Deque<Integer>[] last = new ArrayDeque[26];
        for (int i = 0; i < 26; i++) last[i] = new ArrayDeque<>();
        int[] newParent = parent.clone();
        int[] order = new int[n];
        int[] it = new int[n];
        int cnt = 0;
        Deque<Integer> st = new ArrayDeque<>();
        st.push(0);
        order[cnt++] = 0;
        last[s.charAt(0) - 'a'].push(0);
        while (!st.isEmpty()) {
            int u = st.peek();
            if (it[u] < ch[u].size()) {
                int v = ch[u].get(it[u]++);
                int c = s.charAt(v) - 'a';
                if (!last[c].isEmpty()) newParent[v] = last[c].peek();
                last[c].push(v);
                order[cnt++] = v;
                st.push(v);
            } else {
                st.pop();
                last[s.charAt(u) - 'a'].pop();
            }
        }
        int[] size = new int[n];
        for (int i = n - 1; i >= 0; i--) {
            int u = order[i];
            size[u] += 1;
            if (newParent[u] != -1) size[newParent[u]] += size[u];
        }
        return size;
    }
}