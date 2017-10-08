module Enumerable 
  def my_each
    return to_enum(:my_each) unless block_given?
      for ele in self
        yield ele
      end
  end
  
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    index = 0
    for ele in self
      yield(ele,index)
      index+=1
    end
  end
  
  def my_select
    return to_enum(:my_select) unless block_given?
    new_array = []
    self.my_each do |ele| new_array.push(ele) if yield(ele) end
    new_array
  end
  
  def my_all?
    if block_given?
      self.my_each do |i| return false unless yield(i) end
    else 
      self.my_each do |i| return false unless i end
    end
    return true
  end
  
  def my_none?
    if block_given?
      self.my_each do |i| return false if yield(i) end
    else 
      self.my_each do |i| return false if i end
    end
    return true
  end
  
  def my_count(*item)
    if block_given? 
      (self.select do |ele| yield(ele) end).size
    elsif item.empty?
      self.size
    else
      (self.my_select do |ele| item.include? ele end).size
    end
  end

  def my_inject(*args)
    if block_given? 
      if args[0]
        accumulator = args[0]
        self.my_each do |ele| 
          accumulator = yield(accumulator,ele) 
        end
      else
        self.my_each do |ele| 
          unless accumulator then
            accumulator = ele
            next
          end
          accumulator = yield(accumulator,ele) 
        end
      end
      accumulator
    elsif args[0] && args[1]
        accumulator = args[0]
        self.my_each do |ele| accumulator = (ele.send args[1], accumulator) end
        accumulator
    elsif args[0] && !args[1]
        self.my_each do |ele| 
          unless accumulator then 
            accumulator = ele
            next
          end
          accumulator = (ele.send args[0], accumulator) 
        end
        accumulator
    else 
      puts "no block given"
    end
  end
  
  def my_map(proc=nil)
    return to_enum(:my_map) unless proc || block_given?
    new_array = []
    if proc
      self.my_each do |ele| 
        new_array << proc.call(ele)
      end
      new_array
    else 
      self.my_each do |ele| 
        new_array << yield(ele)
      end
      new_array
    end
  end
  
end
def multiply_els(array)
   array.my_inject {|memo,obj| memo*obj}
end

puts multiply_els([1,3,4])