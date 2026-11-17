
class Solution {
    public int triangularSum(int[] nums) {
        return reduce(nums);
    }

    public int reduce(int[] nums) {
        if (nums.length == 1) {
            return nums[0];
        }

        int[] next = new int[nums.length - 1];

        buildNext(nums, next, 0);

        return reduce(next);
    }

    public void buildNext(int[] nums, int[] next, int i) {
        if (i == next.length) {
            return;
        }

        next[i] = (nums[i] + nums[i + 1]) % 10;

        buildNext(nums, next, i + 1);
    }
}
