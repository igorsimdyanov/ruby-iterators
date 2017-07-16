def block(arr = [])
  if block_given?
    arr.each { |x| yield x }
  else
    arr
  end
end
