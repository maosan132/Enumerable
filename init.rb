module Enumerable

  def my_each
    return to_enum :my_each unless block_given?
    for i in self
      yield(i) 
    end
    self
 
  end
  
  def my_each_with_index

    for i in 0..length - 1
      yield(i, self[i])
    end
   
  end
 

  def my_select
    ary = []
    new_value = self.my_each {|i| yield(i)}     #calls my_each on self, which is the list itself. 
                                                # my_each gets triggered, inside of it there are a loop,
                                                # for each item in the list,  yields something. as it has an argument,
                                                # this is sent to the |i| in the block, and return an operation 
                                                #replacing yield line. The operation will be yield again. }
                                                #
    ary << new          
  

  end

  def my_select_without_myeach  # to understand how it works
    ary = []
    for i in self
        check = yield i
        arr << check
    end
    arr
  end
  
end # end module enum

  my_array = [1, 3, 4, 6, 78, 9]
  my_range = (1..10)
  my_hash = { one: 'one', two: 'two', three: 'three' }
  my_strings = %w(Morris David Cris Stella)
  fruits_in_drawer = [lemon, apple, lemon, apple, grape, grape, pear, peach, kiwi, banana, banana]
  my_array.my_each {|i| puts i }
  puts "********************"
  my_array.my_each_with_index {|k,i| puts "#{k}: #{i}" }
  
  # my_range.my_each { |x| puts x }
  
 #my_strings.select { |x|  x.size < 5 ? }
 fruits_in_drawer.my_select_without_myeach {|i| i == lemon}
 puts
  
  # my_strings.my_select { |x|  x.even? }
  
  puts "end"