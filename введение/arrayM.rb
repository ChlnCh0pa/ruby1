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

def max_el(array)
  # Проверка, что массив не пуст
  if array.empty?
    puts "массив пуст"
  else
    max_el = array[0]
    index = 1
    while index < array.length
      if array[index] > max_el
        max_el = array[index]
      end
      index += 1
    end
   return  max_el
  end
end




# Проверяем ввод пользователя для метода и файла
if ARGV.length == 2
  number_of_method = ARGV[0].to_i
  filepath_of_array = ARGV[1]
else
  puts "Введите номер метода для работы со списком:"
  puts "1 Найти минимальный элемент"
  puts "2 Найти максимальный элемент"
  number_of_method = gets.chomp.to_i
  puts "Введите путь к файлу:"
  filepath_of_array = gets.chomp
end

def chois(num_method, array)
  if array.empty?
    puts "Массив пуст (проверьте доступ к файлу или целостность содержимого)"
  else
    if num_method == 1
      puts "Минимальный элемент списка: #{min_el(array)}"
    elsif num_method == 2
      puts "Максимальный элемент списка: #{max_el(array)}"
      puts "Выбранного метода нет!1!1!1!1!"
    end
  end
end

begin
  
  opened_file = File.read(filepath_of_array)
  array_from_file = opened_file.split.map(&:to_i)


  chois(number_of_method, array_from_file)
rescue => e
  puts "Ошибка: #{e.message}"
end

