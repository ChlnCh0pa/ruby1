def sort_by_frequency(array)
  array.group_by { |e| e }              
       .sort_by { |_, v| -v.size }
       .flat_map { |k, v| [k] * v.size } 
end
