def min_el(array)
  # Проверка, что массив не пуст
  if array.empty?
    puts "массив пуст"
  else
    min_el = array[0]
    index = 1
    while index < array.length
      if array[index] < min_el
        min_el = array[index]
      end
      index += 1
    end
   return  min_el
  end
end



# Проверяем ввод пользователя для метода и файла
if ARGV.length == 2
  number_of_method = ARGV[0].to_i
  filepath_of_array = ARGV[1]
else
  puts "1 Найти минимальный элемент"
  puts "Введите путь к файлу:"
  filepath_of_array = gets.chomp
end


