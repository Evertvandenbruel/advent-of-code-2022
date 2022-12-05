require 'pry'

initial_values = []

stacks = []

def build_begin_stacks(initial_values)
  stacks = Array.new(initial_values.first.chars.size)
  initial_values.reverse.each do |value|
    value.split("").each_with_index do |item, i|
      stacks[i] = [] if stacks[i] == nil
      stacks[i] << item if item != "-"
    end
  end
  stacks
end

File.readlines('input', chump: true).each_with_index do |line, i|
  line = line.gsub("\n", "")
  if line.start_with?("move ")
    amount, from, to = line.scan(/\d+/).map(&:to_i)
    items = stacks[from - 1].pop(amount)
    stacks[to - 1] = stacks[to - 1] + items.reverse
  elsif line.start_with?(" 1")
    stacks = build_begin_stacks(initial_values)
  elsif line != nil
    initial_values << line.gsub("    ","-").gsub("   ", "-").gsub("[", "").gsub("]", "").gsub(" ", "")
  end

end

puts stacks.map(&:last).join