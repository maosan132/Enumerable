# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop: disable Metrics/ModuleLength
module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    for i in self
      yield(i)
    end
    self
  end

  def my_each_with_index
    return to_enum :my_each unless block_given?

    for i in 0...size
      yield(to_a[i], i)
    end
  end

  def my_select
    return to_enum :my_select unless block_given?

    if is_a? Hash
      helper = {}
      my_each { |k, v| helper[k] = v if yield(k, v) }
    else
      helper = []
      my_each { |i| helper << i if yield(i) }
    end
    helper
  end

  def my_all?(args = nil)
    query_result = true
    if args.nil? && !block_given?
      my_each { |i| query_result = false if !i || i.nil? }
    elsif args.nil?
      my_each { |i| query_result = false unless yield(i) }
    elsif args.is_a? Regexp
      my_each { |i| query_result = false unless i.match(args) }
    elsif args.is_a? Module
      my_each { |i| query_result = false unless i.is_a?(args) }
    else
      my_each { |i| query_result = false unless i == args }
    end
    query_result
  end

  def my_count(arg = nil)
    count = 0
    count = size if !block_given? && arg.nil?
    my_each { |i| count += 1 unless i != arg } if arg
    my_each { |i| count += 1 if yield(i) } if block_given?
    count
  end

  def my_any?(arg = nil)
    query_result = false
    if !block_given? && arg.nil?
      my_each { |i| query_result = true unless i.nil? || !i }
    elsif arg.nil?
      query_result = true if count { |i| yield(i) }.positive?
    elsif arg.is_a? Regexp
      my_each { |i| query_result = true if i.match(arg) }
    elsif arg.is_a? Module
      my_each { |i| query_result = true if i.is_a?(arg) }
    else
      count(arg).positive? ? query_result = true : query_result = false
    end
    query_result
  end

  def my_none?(arg = nil)
    query_result = true
    if !block_given? && arg.nil?
      my_each { |i| query_result = false unless i.nil? || !i }
    elsif arg.nil?
      my_each { |i| query_result = false if yield(i) }
    elsif arg.is_a? Regexp
      my_each { |i| query_result = false if i.match(arg) }
    elsif arg.is_a? Module
      my_each { |i| query_result = false if i.is_a?(arg) }
    else
      my_each { |i| query_result = false if i == arg }
    end
    query_result
  end

  def my_map
    return to_enum :my_map unless block_given?

    ary = []
    my_each { |i| ary << yield(i) }
    ary
  end

  def my_map_proc(proc = nil)
    return to_enum :my_map_proc unless block_given?

    ary = []
    my_each { |i| ary << proc ? proc.call(i) : yield(i) }
    ary
  end

  def my_inject3(*arg)
    memo, operator = nil
    if arg[0].is_a?(Symbol)
      operator = arg[0]
      my_each { |i| memo = (memo ? memo.send(operator, i) : i) }
    elsif arg.size == 2
      memo = arg[0]
      operator = arg[1]
      my_each { |i| memo = memo.send(operator, i) }
    else
      memo = arg[0]
      my_each { |i| memo = (memo ? yield(memo, i) : i) }
    end
    memo
  end
end

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop: enable Metrics/ModuleLength

def multiply_els(arr)
  arr.my_inject { |memo, i| memo * i }
end
