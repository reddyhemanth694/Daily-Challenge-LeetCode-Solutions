class Solution {
    int found;

    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        found = 0;
        TreeNode res = dfs(root, p, q);
        return found == 2 ? res : null;
    }

    TreeNode dfs(TreeNode node, TreeNode p, TreeNode q) {
        if (node == null) return null;
        TreeNode l = dfs(node.left, p, q);
        TreeNode r = dfs(node.right, p, q);
        if (node == p || node == q) {
            found++;
            return node;
        }
        if (l != null && r != null) return node;
        return l != null ? l : r;
    }
}