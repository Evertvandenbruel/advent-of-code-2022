LETTER_VALUES = ('a'..'z').to_a + ('A'..'Z').to_a

doubles = []

a = ""
b = ""
c = ""

def get_value_for_double(double)
  LETTER_VALUES.find_index(double) + 1
end

File.readlines('input', chump: true).each_with_index do |line, i|
  parts = line.gsub("\n", "").split("")

  if a.empty? || !c.empty?
    a = parts
    b = ""
    c = ""
  elsif b.empty?
    b = parts
  else
    c = parts
    doubles << (a & b & c)
  end
end

puts doubles.flatten.inject(0) { |sum, double| sum += get_value_for_double(double) }