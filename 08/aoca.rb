require 'pry'

trees = []

def is_already_visible?(tree:)
  tree[:left] || tree[:right] || tree[:top] || tree[:bottom]
end

def mark_as_visible(tree:, max_from_direction:, direction:, total:)
  if max_from_direction < tree[:height]
    max_from_direction = tree[:height]
    total += 1 unless is_already_visible?(tree: tree)  
    tree[direction] = true
  end
  [total, max_from_direction]
end

File.readlines('input', chump: true).each_with_index do |line, i|
  line = line.gsub("\n", "")
  row = []
  line.split("").each do |tree|

    row << { height: tree.to_i, left: false, right: false, top: false, bottom: false } 
  end

  trees << row
end

count = 0

raise :not_a_square unless trees.size == trees[0].size

for i in 0...trees.size
  max_from_left = -1
  max_from_right = -1
  max_from_top = -1
  max_from_bottom = -1 

  for j in 0...trees[0].size
    count, max_from_left = mark_as_visible(tree: trees[i][j], max_from_direction: max_from_left, direction: :left, total: count)

    count, max_from_right = mark_as_visible(tree: trees[i][trees[0].size - j - 1], max_from_direction: max_from_right, direction: :right, total: count)

    count, max_from_top = mark_as_visible(tree: trees[j][i], max_from_direction: max_from_top, direction: :top, total: count)

    count, max_from_bottom = mark_as_visible(tree: trees[trees[0].size - j - 1][i], max_from_direction: max_from_bottom, direction: :bottom, total: count)
  end
end

puts count
