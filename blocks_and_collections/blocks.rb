def count_even_elements(array)
  array.select(&:even?).size
end
