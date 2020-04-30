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
  end
  my_array = [1, 3, 4, 6, 78, 9]
  my_range = (1..10)
  my_hash = { one: 'one', two: 'two', three: 'three' }
  my_strings = %w(Morris David Cris Stella)
  
  my_array.my_each {|i| puts i }
  puts "********************"
  my_array.my_each_with_index {|k,i| puts "#{k}: #{i}" }
  
  # my_range.my_each { |x| puts x }
  
  # my_strings.select { |x|  x.even? }
  # puts
  
  # my_strings.my_select { |x|  x.even? }
  
  puts "end"