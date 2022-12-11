require 'pry'

monkeys = []

Monkey = Struct.new(:name, :items, :command, :divisible_by, :divisible_true, :divisible_false, :count, keyword_init: true) do

  def do_round(monkeys)
    while self.items.size > 0

      self.count = 0 if count == nil
      self.count += 1

      value = inspect_item(old: items.pop) / 3 
      if value % self.divisible_by == 0
        monkeys[self.divisible_true].add_item(value)
      else
        monkeys[self.divisible_false].add_item(value)
      end
    end
  end

  def add_item(item)
    self.items << item
  end

  def inspect_item(old:)
    eval(command)
  end

end

def print_monkeys(monkeys)
  monkeys.each_with_index do |monkey, i|
    puts id: i, list: monkey.items
  end
end

building_monkey = false
new_monkey = nil

File.readlines('input', chump: true).each_with_index do |line, i|
  line = line.gsub("\n", "")

  if line == ""
    monkeys << new_monkey
    new_monkey = nil
  else
    if new_monkey == nil
      new_monkey = Monkey.new() 
    end
    if line.include?("Starting items:")
      line = line.gsub("  Starting items: ", "")
      new_monkey.items = line.split(", ").map(&:to_i)
    elsif line.include?("Operation: new = ")
      line = line.gsub("  Operation: new = ", "")
      new_monkey.command = line
    elsif line.include?("Test: divisible by")
      new_monkey.divisible_by = line.scan(/\d+/).first.to_i
    elsif line.include?("If true: throw to monkey")
      new_monkey.divisible_true = line.scan(/\d+/).first.to_i
    elsif line.include?("If false: throw to monkey")
      new_monkey.divisible_false = line.scan(/\d+/).first.to_i
    end
  end
end

monkeys << new_monkey

20.times do |i|
  monkeys.each do |monkey|
    monkey.do_round(monkeys)
  end
end

puts monkeys.map(&:count).sort.last(2).inject(:*)
