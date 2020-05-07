require_relative 'enumerable.rb' 
include Enumerable

def multiply_els(arr)
  arr.my_inject { |memo, i| memo * i }
end



my_array = [1, 3, 4, 6, 78, 9, 3]
my_range = 1..10
my_hash = { one: 'one', two: 'two', three: 'three' }
my_strings = %w(Morris David Cris Stella)


#my_array.my_each { |i| puts i }
#my_strings.my_each_with_index { |k,i| puts "#{k}: #{i}" }

# my_strings.select { |x|  x.size < 5 ? }
# my_strings.my_select_without_myeach { |i| i == "lemon"}
# n = my_hash.my_select { |k,i| i == "one"}
# puts n
# puts n.class
# puts my_hash.my_none?(6)
# puts my_hash.my_any? { |i| i == 5}
# puts my_hash.my_none? { |i| i == 5}

# my_array.my_count()
# my_array.my_count(3)
# my_array.my_count { |i| i > 5}
# my_array.my_inject6(2, :+)
# my_array.my_inject6(:+)
puts my_hash.my_map { |k,i| i+i }
puts my_strings.my_map { |i| i+i }
proc = proc {|i| i * 2 }
# my_array.my_all? { |i| i == 0}

# my_strings.my_select { |x|  x.even? }

puts "->normal enumerables:"
puts my_hash.map { |k,i| i+i }

# puts a = my_hash.none?(6)
# b = my_hash.any? { |i| i == 5}
# c = my_hash.none? { |i| i == 5}
# d = my_hash.all?
# puts "-----------#{a} #{b} #{c} #{d}"

# def my_count(arg = nil)
#   count = 0
#   count = size if !block_given? && arg.nil?
#   my_each { |i| count += 1 unless i != arg } if arg
#   my_each { |i| count += 1 if yield(i) } if block_given?
#   puts count
# end  