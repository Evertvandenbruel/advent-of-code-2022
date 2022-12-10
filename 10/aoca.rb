x = 1

commands = []
executing = false

File.readlines('example', chump: true).each_with_index do |line, i|
  line = line.gsub("\n", "")

  if line.include?("noop")
    commands << :noop
  else
    number = line.gsub("addx ", "")
    commands <<  number.to_i
  end
end

i = 1

sum = 0

while !commands.empty?
  if i == 20
    sum += x * 20
  elsif (i - 20) % 40 == 0
    sum += i * x
  end

  command = commands.first
  if executing
    x += command
    executing = false
    commands = commands.drop(1)
  else
    if command == :noop
      commands = commands.drop(1)
    else
      executing = true
    end
  end

  i += 1
end

# puts x.inspect
puts sum