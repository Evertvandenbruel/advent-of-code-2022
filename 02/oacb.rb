# A for Rock, B for Paper, and C for Scissors
# X for Rock, Y for Paper, and Z for Scissors.
# X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win

SCORES = { "A X" => 3, "A Y" => 4, "A Z" => 8, "B X" => 1, "B Y" => 5, "B Z" => 9, "C X" => 2, "C Y" => 6, "C Z" => 7 }

score = 0

File.readlines('input', chump: true).each do |line|
  score += SCORES[line.gsub("\n", "")]
end

puts score