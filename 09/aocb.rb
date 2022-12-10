require 'pry'

class Aoc

  CENTER_VERTICAL = 500
  CENTER_HORIZONTAL = 50

  def initialize
    @rope = []
    10.times do 
      @rope << [CENTER_VERTICAL, CENTER_HORIZONTAL]
    end

    @start = [CENTER_VERTICAL, CENTER_HORIZONTAL]
    @visited = [[CENTER_VERTICAL, CENTER_HORIZONTAL]]
  end

  def read_input
    File.readlines('input').each do |line|
      direction, amount = line.gsub("\n", "").split(" ")
      move(head: @rope[0], direction: direction, amount: amount.to_i)
    end

    puts @visited.uniq.count
  end

  def print_state
    @state = []

    1000.times do
      @state << ("." * 1000).split("")
    end
    
    @visited.each do |visit|
      @state[visit[0]][visit[1]] = "x"
    end

    @state[@tail[0]][@tail[1]] = "T"
    @state[@head[0]][@head[1]] = "H"

    @state.each do |line|
      puts line.join("")
    end
  end

  def move_tail(tail:, parent:)
    puts "---"
    puts tail.inspect
    puts parent.inspect
    vertical = parent[0] - tail[0]
    horizonal = parent[1] - tail[1]

    return if [-1, 0, 1].include?(vertical.abs) && [-1, 0, 1].include?(horizonal.abs)

    if vertical == 0
      if horizonal.positive?
        tail[1] += 1
      else
        tail[1] -= 1
      end
    elsif horizonal == 0
      if vertical.positive?
        tail[0] += 1
      else
        tail[0] -= 1
      end
    else
      if vertical.abs == 2
        tail[0] += vertical / 2 
      else
        tail[0] += vertical
      end

      if horizonal.abs == 2
        tail[1] += horizonal / 2 
      else
        tail[1] += horizonal
      end
    end
  end

  def move(head:, direction:, amount:)
    if direction == 'R'
      head[1] += 1
    elsif direction == 'L'
      head[1] -= 1
    elsif direction == 'U'
      head[0] -= 1
    elsif direction == 'D'
      head[0] += 1
    end
    amount -= 1

    move_tail(tail: @rope[0], parent: head)

    (1..9).each do |i| 
      move_tail(tail: @rope[i], parent: @rope[i - 1])
    end

    @visited << [@rope[9][0], @rope[9][1]]

    if amount >= 1
      move(head: @rope[0], direction: direction, amount: amount)
    end
  end

end

Aoc.new.read_input
