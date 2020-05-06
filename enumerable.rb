module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    for i in self
      yield(i)
    end
    self
    puts
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
    print ary

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

end
