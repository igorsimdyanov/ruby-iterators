def walk(arr = [], &proc)
  arr.each do |el|
    proc.call(el) if el.is_a? String
    el.each { |_dir, files| walk(files, &proc) } if el.is_a? Hash
  end
end
