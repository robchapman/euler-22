class NewNamesScores
  attr_reader :names

  # Ascending alphabetic sort
  DEFAULT_SORT = ->(a, b) { a <=> b }
  # Score is calculated based on sum of lettters alphabetic order (A = 1, B = 2, etc.)
  # #ord is used to convert character to ascii code
  DEFAULT_SCORE = ->(name) { name.scan(/[a-zA-Z]/).sum { |chr| chr.upcase.ord - 64 } }
  # Total score is equivalent to sum of individual names  multuplied by their
  # position in the sorted array of names
  DEFAULT_TOTAL = lambda { |names, score|
    total = 0
    names.each_with_index { |name, index| total += score.call(name) * (index + 1) }
    total
  }

  def initialize(names, sort = DEFAULT_SORT, score = DEFAULT_SCORE, total = DEFAULT_TOTAL)
    check_args(names)
    @names = names.is_a?(File) ? names.read.split(',') : names
    @sort = sort
    @score = score
    @total = total
  end

  def sorted_names
    @sorted_names ||= @names.sort &@sort
  end

  def score(name, position)
    # Score is calculated based on sum of lettters alphabetic order (A = 1, B = 2, etc.)
    # #ord is used to convert character to ascii code
    name.split('').map { |chr| chr.ord - 64 }.sum * position
  end

  def total_score
    @total_score ||= sorted_names.map.with_index { |name, index| score(name, index + 1) }.sum
  end

  private

  def check_args(names)
    unless names.is_a?(Array) || names.is_a?(File)
      raise_arg_err
    end
  end

  def raise_arg_err
    raise ArgumentError, "Argument must be either an Array of Strings or File
      containing comma seperated string values"
  end
end

names = File.read(File.dirname(__FILE__) + '/names.txt').split(',')
new_names_scores = NewNamesScores.new(names)
puts new_names_scores.total_score

# total_score = NamesScores.total_score(names).to_s.split('')
# ((total_score.size - 1) / 3).times { |i| total_score.insert(-4 * i - 4, ',') }
# result = "Project Euler - Problem 22 Solution: #{total_score.join('')}"
# puts result
