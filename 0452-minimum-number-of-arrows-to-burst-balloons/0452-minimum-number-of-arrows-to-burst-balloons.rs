impl Solution {
    pub fn find_min_arrow_shots(mut points: Vec<Vec<i32>>) -> i32 {
        points.sort_by_key(|p| p[1]);

        let mut arrows = 1;
        let mut arrow = points[0][1];

        for i in 1..points.len() {
            if points[i][0] > arrow {
                arrows += 1;
                arrow = points[i][1];
            }
        }

        arrows
    }
}