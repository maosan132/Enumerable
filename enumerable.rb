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
    puts ary
  end

  def my_map_proc(proc = nil)
    return to_enum :my_map_proc unless block_given?

    ary = []
    my_each { |i| ary << proc ? proc.call(i) : yield(i) }
    ary
  end

  def my_inject(arg = nil)
    if !arg && block_given?
      memo = self[0]
      first_memo = self[1..-1]
    else
      memo = arg
      first_memo = self
    end
    first_memo.my_each do |i|
      memo = yield(memo, i) if block_given?
    end
    puts memo
  end
end

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
# rubocop: enable Metrics/ModuleLength

def multiply_els(arr)
  arr.my_inject { |memo, i| memo * i }
end

my_array = [1, 3, 4, 6, 78, 9, 3]
my_range = 1..10
my_hash = { one: 'one', two: 'two', three: 'three' }
my_strings = %w(Morris David Cris Stella)

puts 
puts my_array.my_count {|i| i == 78}
puts my_array.my_count2 {|i| i == 78}
puts "------------"
puts my_array.count {|i| i == 78}

# puts my_strings.my_any?("ssss")
# puts my_strings.my_any?
# puts my_strings.any?("dsdsd")