class Solution {
    public int[] runningSum(int[] nums) {
        int[] ans = new int[nums.length];

        for (int i = 0; i < nums.length; i++) {
            ans[i] = calculate(nums, i);
        }

        return ans;
    }

    public int calculate(int[] nums, int index) {
        if (index == 0) {
            return nums[0];
        }

        return calculate(nums, index - 1) + nums[index];
    }
}