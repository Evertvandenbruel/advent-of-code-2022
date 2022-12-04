amount = 0

File.readlines('input', chump: true).each_with_index do |line, i|
  values = line.gsub("\n", "").split(",").map{|i|i.split("-")}.flatten
  first = (values[0]..values[1]).to_a
  second = (values[2]..values[3]).to_a
  total = (first & second)
  amount += 1 if total.size == first.size || total.size == second.size
end

puts amount 