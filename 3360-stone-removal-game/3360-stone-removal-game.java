class Solution {
    public boolean canAliceWin(int n) {
        int take = 10;
        boolean aliceTurn = true;
        while (n >= take) {
            n -= take;
            take--;
            aliceTurn = !aliceTurn;
        }
        return !aliceTurn;
    }
}