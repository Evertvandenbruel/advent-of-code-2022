current = 0
results = []

File.readlines('input').each do |line|
  if Integer(line, exception: false)
    current = current + line.to_i
  else
    results << current
    current = 0
  end
end

results << current
puts results.sort.last(3).sum