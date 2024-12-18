def min_el(array)
  # Проверка, что массив не пуст
  if array.empty?
    return nil
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
    return nil
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

def num_first(array)
  # Проверка, что массив не пуст
  if array.empty?
    return nil
  else
    index = 0
    while index < array.length
      if array[index] >= 0
        return index + 1  
      end
      index += 1
    end
    "В массиве нет положительных элементов"
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
  puts "3 Найти первый положительный элементе"
  number_of_method = gets.chomp.to_i
  puts "Введите путь к файлу:"
  filepath_of_array = gets.chomp
end

def chois(num_method, array)
  if array.empty?
   return nil
  else
    if num_method == 1
      puts "Минимальный элемент списка: #{min_el(array)}"
    elsif num_method == 2
      puts "Максимальный элемент списка: #{max_el(array)}"
    elsif num_method == 3
      puts "Первый положительный элемент списка: #{num_first(array)}"
    else
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

