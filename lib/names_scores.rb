class NamesScores
  def self.total_score(names)
    # Error Handling and file reading?
    # return 0 unless names.is_a? Array || names.is_a? File
    return 0 unless names.is_a? Array

    sorted_names = names.map { |name| name.upcase.gsub(/[^A-Z]/, '') }.sort
    sorted_names.map.with_index { |name, index| (index + 1) * score(name) }.sum
  end

  def self.score(name)
    name.split('').map { |chr| chr.ord - 64 }.sum
  end
end

