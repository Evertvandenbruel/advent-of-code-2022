require 'pry'

class Aoc

  CENTER = 500

  def initialize
    @head = [CENTER, CENTER]
    @tail = [CENTER, CENTER]
    @start = [CENTER, CENTER]

    @visited = [[CENTER, CENTER]]
  end

  def read_input
    File.readlines('input').each do |line|
      direction, amount = line.gsub("\n", "").split(" ")
      move(direction: direction, amount: amount.to_i)
    end

    # print_state
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

  def move_tail
    vertical = @head[0] - @tail[0]
    horizonal = @head[1] - @tail[1]

    return if [-1, 0, 1].include?(vertical.abs) && [-1, 0, 1].include?(horizonal.abs)

    if vertical == 0
      if horizonal.positive?
        @tail[1] += 1
      else
        @tail[1] -= 1
      end
    elsif horizonal == 0
      if vertical.positive?
        @tail[0] += 1
      else
        @tail[0] -= 1
      end
    else
      if vertical.abs == 2
        @tail[0] += vertical / 2 
      else
        @tail[0] += vertical
      end

      if horizonal.abs == 2
        @tail[1] += horizonal / 2 
      else
        @tail[1] += horizonal
      end
    end
  end

  def move(direction:, amount:)
    if direction == 'R'
      @head[1] += 1
    elsif direction == 'L'
      @head[1] -= 1
    elsif direction == 'U'
      @head[0] -= 1
    elsif direction == 'D'
      @head[0] += 1
    end
    amount -= 1

    move_tail
    # print_state

    @visited << [@tail[0], @tail[1]]

    if amount >= 1
      move(direction: direction, amount: amount)
    end
  end

end

Aoc.new.read_input
