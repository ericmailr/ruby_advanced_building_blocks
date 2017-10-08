def bubble_sort_by(array)
  sorted = false
  until sorted
    sorted = true
    array.each_with_index do |val, i|
      if (i<array.length-1 && yield(val, array[i+1]) > 0)
        array[i], array[i+1] = array[i+1], val
        sorted = false
      end
    end
  end
  array
end

sorted = bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end

puts sorted