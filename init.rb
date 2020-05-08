require_relative 'enumerable.rb'

def multiply_els(arr)
  arr.my_inject { |memo, i| memo * i }
end
