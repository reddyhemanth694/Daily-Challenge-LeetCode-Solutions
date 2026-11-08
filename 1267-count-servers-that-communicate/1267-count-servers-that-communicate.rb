# Brute Force
# def count_servers(grid)
#     m = grid.length
#     n = grid[0].length
#     ans = 0
#     (0...m).each do |i|
#         (0...n).each do |j|
#             next unless grid[i][j] == 1
#             found = false
#             (0...n).each { |k| found = true if k != j && grid[i][k] == 1 }
#             (0...m).each { |k| found = true if k != i && grid[k][j] == 1 }
#             ans += 1 if found
#         end
#     end
#     ans
# end

# Better Approach
# def count_servers(grid)
#     m = grid.length
#     n = grid[0].length
#     row = Array.new(m, 0)
#     col = Array.new(n, 0)
#     (0...m).each do |i|
#         (0...n).each do |j|
#             if grid[i][j] == 1
#                 row[i] += 1
#                 col[j] += 1
#             end
#         end
#     end
#     ans = 0
#     (0...m).each do |i|
#         (0...n).each do |j|
#             ans += 1 if grid[i][j] == 1 && (row[i] > 1 || col[j] > 1)
#         end
#     end
#     ans
# end

# Optimized Approach: one pass, answer = total - isolated
# @param {Integer[][]} grid
# @return {Integer}
def count_servers(grid)
    m = grid.length
    n = grid[0].length
    row_cnt = Array.new(m, 0)
    row_col = Array.new(m, 0)
    col_cnt = Array.new(n, 0)
    total = 0
    (0...m).each do |i|
        (0...n).each do |j|
            if grid[i][j] == 1
                row_cnt[i] += 1
                row_col[i] += j
                col_cnt[j] += 1
                total += 1
            end
        end
    end
    isolated = 0
    (0...m).each do |i|
        isolated += 1 if row_cnt[i] == 1 && col_cnt[row_col[i]] == 1
    end
    total - isolated
end