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
  #calls my_each on self, which is the list itself. 
# my_each gets triggered, inside of it there is a loop,
# for each item in the list,  yields something. as it has an argument,
# this is sent to the |i| in the block, and return an operation 
#replacing yield line. The operation will be yield again. }
#

  def my_select
    return to_enum :my_each unless block_given?
    ary = []
    
    self.my_each do |i| 
      #check = yield(i)
      #if yield i 
      if yield(i) then ary << i
      end
    
    end
    print ary
  end
=begin
  def my_select_without_myeach  to understand how it works, delete this def
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
    self.my_each do |i|
      if yield(i) then count += 1
      end
    end
    puts size == count ? true : false
  end

  def my_any?
    count = 0
      self.my_each do |i|
        if yield(i) then count += 1
        end
        return true if count == 1
      end
      # puts count > 0 ? true : false
      return false
    end


  def my_none?
    count = 0
      self.my_each do |i|
        if yield(i) then count += 1
        end
      end
      puts count == 0 ? true : false
    end

 

  def my_count(arg = nil)
    count = 0
    count = size if !block_given? && arg.nil?
    self.my_each {|i| count += 1 unless i != arg} if arg 
    self.my_each {|i| count += 1 if yield(i)} if block_given?
    puts count
  end
  
  def my_map
    return to_enum :my_map unless block_given?
    ary = []
    self.my_each do |i| 
      ary << yield(i)        
    end
    print ary
  end

  def my_inject3(arg = nil)
    each { |i| memo = arg ? yield(memo, i) : i}
    memo
  end

  def my_inject2(memo = nil)
    my_each { |i| memo = memo.nil? ? x : yield(memo, i) }
    puts memo
  end

  def my_inject4(arg = nil)
    for i in self
     arg = arg.nil? ? i : yield(arg, i) 
    end
    puts arg
  end


 def my_inject(arg = nil)    
    memo = arg ? arg : self[0]
    # self.my_each do |i|
    #   yield
    for i in 0...length
      puts "#{memo}:#{self[i]} Results=#{yield(memo,self[i])}"
      memo = yield(memo,self[i])
    end
    return memo
  end


  def my_inject5(arg = nil)
    # if no initial value given then
    arg ? total = arg : total = self[0]
    for i in 1..self.length
      total = yield(total, i)
    end
    puts total
  end

  def my_inject6(arg = nil, operation = nil)
    if arg.is_a?(Symbol) || (!arg && block_given?)
      memo = self[0]
      first_memo = self[1..-1]
    else
      memo = arg
      first_memo = self
    end
    symbol = operation || (arg.respond_to?(Symbol) ? arg : nil)
    first_memo.my_each do |i|
      memo = memo.send(symbol, i) if symbol
      memo = yield(memo, i) if block_given?
    end
    puts memo
  end

  def my_inject7(memo=nil)
    unless memo
      memo = self[0]
      start = 1
    else
      start = 0
    end
    start.upto(self.size - 1) { |i| memo = yield(memo, self[i]) }
    memo
  end

  def my_inject8(initial = nil, sym = nil)
    case 
    when initial.is_a?(Symbol)
      sym = initial
      memo = self[0]
      self[1..-1].my_each do |x|
        memo = memo.send(sym, x)
      end
      puts memo
    when initial && sym
      memo = initial
      self.my_each do |x|
        memo = memo.send(sym,x)
      end
      puts memo
    when initial && block_given?
      memo = initial
      self.my_each do |x|
        memo = yield(memo,x)
      end
      puts memo
    when block_given?
      memo = self[0]
      self[1..-1].my_each do |x|
        memo = yield(memo,x)
      end
      puts memo
    end
  end
  #--------------------------------
end
# end module enum

my_array = [1, 3, 4, 6, 78, 9, 3]
my_range = (1..10)
my_hash = { one: 'one', two: 'two', three: 'three' }
my_strings = %w(Morris David Cris Stella)
fruits_in_drawer = %w[lemon, apple, lemon, apple, grape, grape, pear, peach, kiwi, banana, banana]


# my_array.my_each {|i| puts i }
# my_array.my_each
# my_array.my_each_with_index {|k,i| puts "#{k}: #{i}" }

# my_range.my_each { |x| puts x }

# my_strings.select { |x|  x.size < 5 ? }
# fruits_in_drawer.my_select_without_myeach {|i| i == "lemon"}
# my_array.my_select {|i| i > 5}
# my_array.my_any? {|i| i == 5}

# my_array.my_count()
# my_array.my_count(3)
# my_array.my_count {|i| i > 5}
my_array.my_inject8(2, :+)
my_array.my_inject8(:+)
my_array.my_inject8(2) {|m,i| m+i}
my_array.my_inject8 {|m,i| m+i}
#my_array.my_map {|i| i * 2}
puts "-*-*-*-*-*--*-"
# my_array.my_all? {|i| i == 0}
puts

# my_strings.my_select { |x|  x.even? }
  
  puts "-------this is the eof------------"