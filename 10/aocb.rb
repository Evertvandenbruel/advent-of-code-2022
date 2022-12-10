x = 1
i = 0
sum = 0
row = []
row_counter = 0
commands = []
executing = false

File.readlines('input', chump: true).each_with_index do |line, i|
  line = line.gsub("\n", "")

  if line.include?("noop")
    commands << :noop
  else
    number = line.gsub("addx ", "")
    commands <<  number.to_i
  end
end

def get_char(i:, sum:)
  if [i - 1, i, i + 1].include?(sum)
    "#"
  else
    "."
  end
end

while !commands.empty?
  row << get_char(i: row_counter, sum: x)

  command = commands.first
  if executing
    x += command
    executing = false
    commands = commands.drop(1)
  else
    if command == :noop
      # puts x
      commands = commands.drop(1)
    else
      executing = true
    end
  end

  row_counter += 1
  i += 1

  if i % 40 == 0
    row_counter = 0
    puts row.join
    row = []
  end
end
