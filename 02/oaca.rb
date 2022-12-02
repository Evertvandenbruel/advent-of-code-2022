# A for Rock, B for Paper, and C for Scissors
# X for Rock, Y for Paper, and Z for Scissors.

SCORES = { "A X" => 4, "A Y" => 8, "A Z" => 3, "B X" => 1, "B Y" => 5, "B Z" => 9, "C X" => 7, "C Y" => 2, "C Z" => 6 }

score = 0

File.readlines('input', chump: true).each do |line|
  score += SCORES[line.gsub("\n", "")]
end

puts score