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

    for i in 0...size
      yield(to_a[i], i)
    end
  end

  def my_select
    return to_enum :my_select unless block_given?

    if is_a? Hash
      helper = {}
      my_each { |k, v| helper[k] = v if yield k, v }
    else
      helper = []
      my_each { |i| helper << i if yield(i) }
    end
    helper
  end

  # def my_all?(arg = nil)
  #   return true unless block_given?

  #   count = 0
  #   my_each do |i|
  #     no_nil = i == false || nil ? false : true
  #     count += 1 if yield(i)
  #   end
  #   size == count ? true : false
    
  # end

  def my_all?(arg = nil)
    query_result = false
    if !block_given? && arg.nil?
      my_each { |i| query_result = true unless !i || i.nil?}
    elsif arg.nil?
      my_each { |i| query_result = true if yield(i) }
    elsif arg.is_a? Regexp
      my_each { |i| query_result = true if i.match(arg) }
    elsif arg.is_a? :class
      my_each { |i| query_result = true if i.is_a?(arg) }
    else
      my_each { |i| query_result = true if i == arg }
    end
    query_result
  end
  
  # def my_any?
  #   count = 0
  #   my_each do |i|
  #     if yield(i) then count += 1
  #     end
  #     return true if count == 1
  #   end
  #   # puts count > 0 ? true : false
  #   false
  # end

  def my_count(arg = nil)
    count = 0
    count = size if !block_given? && arg.nil?
    my_each { |i| count += 1 unless i != arg } if arg
    my_each { |i| count += 1 if yield(i) } if block_given?
    puts count
  end

  def my_any?(arg = nil)
    query_result = false
    if !block_given? && arg.nil?
      my_each { |i| query_result = true unless i.nil? || !i }
    elsif arg.nil?
      self.my_count { yield }
      check = check > 0
      puts "check #{check}"
      #query_result = true if 
      # my_each { |i| query_result = true if yield(i) }
    elsif arg.is_a? Regexp
      my_each { |i| query_result = true if i.match(arg) }
    elsif arg.is_a? :class
      my_each { |i| query_result = true if i.is_a?(arg) }
    else
      my_each { |i| query_result = true if i == arg }
    end
    puts query_result
  end


  # def my_any(arg = nil)

  #   self.my_count {}


  # end
  # def my_none?
  #   count = 0
  #     my_each do |i|
  #       if yield(i) then count += 1
  #       end
  #     end
  #     puts count == 0 ? true : false
  # end

  def my_none?(arg = nil)
    query_result = true
    if !block_given? && arg.nil?
      my_each { |i| query_result = false unless i.nil? || !i }
    elsif arg.nil?
      my_each { |i| query_result = false if yield(i) }
    elsif arg.is_a? Regexp
      my_each { |i| query_result = false if i.match(arg) }
    elsif arg.is_a? :class
      my_each { |i| query_result = false if i.is_a?(arg) }
    else
      my_each { |i| query_result = false if i == arg }
    end
    puts query_result
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
