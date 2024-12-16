def cyclic_shift(array)
array[-2..-1] + array[0...-2]
end

loop do
puts "Выберите задачу для выполнения:"
puts "1. Циклический сдвиг массива вправо на две позиции"
puts "0. Выход"

choice = gets.to_i

case choice
when 1
puts "Введите элементы массива через пробел:"
input_array = gets.split.map(&:to_i)
shifted_array = cyclic_shift(input_array)
puts "Результат сдвига: #{shifted_array}"
when 0
puts "Выход из программы."
break
else
puts "Неверный выбор. Попробуйте снова."
end
end