require_relative 'names_scores'

# Project Euler Solution
names = File.read(File.dirname(__FILE__) + '/names.txt').split(',')
total_score = NamesScores.total_score(names).to_s.split('')
((total_score.size - 1) / 3).times { |i| total_score.insert(-4 * i - 4, ',') }
result = "Project Euler - Problem 22 Solution: #{total_score.join('')}"
puts result
