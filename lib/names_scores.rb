class NamesScores
  def self.total_score(names)
    names_arr = names.is_a?(File) ? names.read.split(',') : names
    check_args(names_arr)
    sorted_names = names_arr.map { |name| name.upcase.gsub(/[^A-Z]/, '') }.sort
    sorted_names.map.with_index { |name, index| (index + 1) * score(name) }.sum
  end

  private_class_method def self.score(name)
    name.split('').map { |chr| chr.ord - 64 }.sum
  end

  private_class_method def self.check_args(names)
    unless names.is_a?(Array) && names.all? { |name| name.is_a? String }
      raise_arg_err
    end
  end

  private_class_method def self.raise_arg_err
    raise ArgumentError, "Argument must be either an Array of Strings or File
      containing comma seperated string values"
  end
end
