# @param {Integer[][]} points
# @return {Integer}
def find_min_arrow_shots(points)
    points.sort_by! { |p| p[1] }

    arrows = 1
    arrow = points[0][1]

    (1...points.length).each do |i|
        if points[i][0] > arrow
            arrows += 1
            arrow = points[i][1]
        end
    end

    arrows
end