require 'pry'

trees = []

File.readlines('input', chump: true).each_with_index do |line, i|
  line = line.gsub("\n", "")
  row = []
  line.split("").each do |tree|

    row << { height: tree.to_i, score: 0 } 
  end

  trees << row
end

max = 0

raise :not_a_square unless trees.size == trees[0].size



def calculate_score(trees:, tree:, i:, j:)
  left = move(trees: trees, tree: tree, i: i, j: j, direction: :left)
  right = move(trees: trees, tree: tree, i: i, j: j, direction: :right)
  up = move(trees: trees, tree: tree, i: i, j: j, direction: :up)
  down = move(trees: trees, tree: tree, i: i, j: j, direction: :down)

  left * right * up * down
end

def move(trees:, tree:, i:, j:, direction:, count: 0)

  neighbour = nil

  if direction == :left
    if 0 < j
      j -= 1
      neighbour = trees[i][j]
      if neighbour[:height] < tree[:height]
        count = move(trees: trees, tree: tree, i: i, j: j, direction: :left, count: count + 1)
      else
        count += 1
      end
    end
  end

  if direction == :right
    if j < trees.size - 1
      j += 1
      neighbour = trees[i][j]
      if neighbour[:height] < tree[:height]
        count = move(trees: trees, tree: tree, i: i, j: j, direction: :right, count: count + 1)
      else
        count += 1
      end
    end
  end

  if direction == :up
    if 0 < i
      i -= 1
      neighbour = trees[i][j]
      if neighbour[:height] < tree[:height]
        count = move(trees: trees, tree: tree, i: i, j: j, direction: :up, count: count + 1)
      else
        count += 1
      end
    end
  end

  if direction == :down
    if i < trees.size - 1
      i += 1
      neighbour = trees[i][j]
      if neighbour[:height] < tree[:height]
        count = move(trees: trees, tree: tree, i: i, j: j, direction: :down, count: count + 1)
      else
        count += 1
      end
    end
  end

  count
end

for i in 0...trees.size
  for j in 0...trees[0].size
    score = calculate_score(trees: trees, tree: trees[i][j], i: i, j: j)
    max = score if max < score
  end
end

puts max
