LETTER_VALUES = ('a'..'z').to_a + ('A'..'Z').to_a

doubles = []

def get_value_for_double(double)
  LETTER_VALUES.find_index(double) + 1
end

File.readlines('input', chump: true).each_with_index do |line, i|
  parts = line.gsub("\n", "").split("")
  parts = parts.each_slice(parts.size / 2).to_a

  doubles << (parts[0] & parts[1])
end

puts doubles.flatten.inject(0) { |sum, double| sum += get_value_for_double(double) }