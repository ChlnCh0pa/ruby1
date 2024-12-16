def cyclic_shift(array)
array[-2..-1] + array[0...-2]
end

def cyclic_shift_one(array)
array[-1..-1] + array[0...-1]
end

def count_even_elements(array)
array.select(&:even?).size
end

def count_min_elements(array)
min_value = array.min
array.count(min_value)
end

def sort_by_frequency(array)
array.group_by { |e| e }
.sort_by { |_, v| -v.size }
.flat_map { |k, v| [k] * v.size }
end
loop do
puts "Выберите задачу для выполнения:"
puts "1. Циклический сдвиг массива вправо на две позиции"
puts "2. Циклический сдвиг массива вправо на одну позицию"
puts "3. Найти количество чётных элементов в массиве"
puts "4. Найти количество минимальных элементов в массиве"
puts "5. Упорядочить список по количеству встречаемости элементов"
puts "0. Выход"

choice = gets.to_i

case choice
when 1
puts "Введите элементы массива через пробел:"
input_array = gets.split.map(&:to_i)
shifted_array = cyclic_shift(input_array)
puts "Результат сдвига: #{shifted_array}"
when 2
puts "Введите элементы массива через пробел:"
input_array = gets.split.map(&:to_i)
shifted_array = cyclic_shift_one(input_array)
puts "Результат сдвига: #{shifted_array}"
when 3
puts "Введите элементы массива через пробел:"
input_array = gets.split.map(&:to_i)
even_count = count_even_elements(input_array)
puts "Количество чётных элементов: #{even_count}"
when 4
puts "Введите элементы массива через пробел:"
input_array = gets.split.map(&:to_i)
min_count = count_min_elements(input_array)
puts "Количество минимальных элементов: #{min_count}"
when 5
puts "Введите элементы списка через пробел:"
input_array = gets.split.map(&:to_i)
sorted_array = sort_by_frequency(input_array)
puts "Список, упорядоченный по частоте встречаемости: #{sorted_array}"
when 0
puts "Выход из программы."
break
else
puts "Неверный выбор. Попробуйте снова."
end
end