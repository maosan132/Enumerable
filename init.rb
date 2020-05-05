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

    for i in 0...length
      yield(i, self[i])
    end
  end

  def my_select
    return to_enum :my_each unless block_given?

    ary = []
    my_each do |i|
      # check = yield(i)
      # if yield i
      ary << i if yield(i)
      end
    end
    print ary
  end
=begin
  def my_select_without_myeach
    ary = []
    for i in self
      check = yield i
      if check then ary << check
      end
    end
    print ary
  end
=end

  def my_all?
    count = 0
    my_each do |i|
      count += 1 if yield(i)
    end
    size == count ? true : false
  end
  def my_any?
    count = 0
    my_each do |i|
      if yield(i) then count += 1
      end
      return true if count == 1
    end
    # puts count > 0 ? true : false
    false
  end

  def my_none?
    count = 0
      my_each do |i|
        if yield(i) then count += 1
        end
      end
      puts count == 0 ? true : false
  end

  def my_count(arg = nil)
    count = 0
    count = size if !block_given? && arg.nil?
    my_each { |i| count += 1 unless i != arg } if arg
    my_each { |i| count += 1 if yield(i) } if block_given?
    puts count
  end  

  def my_map
    return to_enum :my_map unless block_given?

    ary = []
    my_each do |i|
      ary << yield(i)
    end
    print ary
  end

  def my_inject(arg = nil)
    # arg was not given and block was
    if !arg && block_given?
      memo = self[0]
      first_memo = self[1..-1]
    else # arg was given
      memo = arg
      first_memo = self
    end
    first_memo.my_each do |i|
    memo = yield(memo, i) if block_given?
    end
    puts memo
  end
  #--------------------------------
end

def multiply_els(arr)
  arr.my_inject { |memo, i| memo * i }
end

# end module enum

my_array = [1, 3, 4, 6, 78, 9, 3]
my_range = (1..10)
my_hash = { one: 'one', two: 'two', three: 'three' }
my_strings = %w(Morris David Cris Stella)
fruits_in_drawer = %w[lemon, apple, lemon, apple, grape, grape, pear, peach, kiwi, banana, banana]


# my_array.my_each { |i| puts i }
# my_array.my_each
# my_array.my_each_with_index { |k,i| puts "#{k}: #{i}" }

# my_range.my_each { |x| puts x }

# my_strings.select { |x|  x.size < 5 ? }
# fruits_in_drawer.my_select_without_myeach { |i| i == "lemon"}
# my_array.my_select { |i| i > 5}
# my_array.my_any? { |i| i == 5}

# my_array.my_count()
# my_array.my_count(3)
# my_array.my_count { |i| i > 5}
# my_array.my_inject6(2, :+)
# my_array.my_inject6(:+)
my_array.my_inject(2) { |m,i| m + i}
my_array.my_inject { |m,i| m + i}

multiply_els(my_array)
#my_array.my_map { |i| i * 2}
puts "-*-*-*-*-*--*-"
# my_array.my_all? { |i| i == 0}
puts

# my_strings.my_select { |x|  x.even? }


  
puts "-------this is the eof------------"