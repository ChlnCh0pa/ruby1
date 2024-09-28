# Получение имени пользователя текущей сессии 
name = ENV['USERNAME']

if name.nil?
  puts "Не удалось получить имя пользователя."
  exit
end

# Приветствие с использованием форматирования строки
puts "Привет, #{name}!"

puts "Какой твой любимый язык программирования?"
favorite_language = gets.chomp.downcase

# Ответы в зависимости от языка
if favorite_language == "ruby"
  puts "#{name}, ты подлиза!"
else
  puts "#{name}, скоро ты полюбишь Ruby!"
  
  # Комментарии для различных языков
 case favorite_language
  when "python"
    puts " ... "
  when "javascript"
    puts " JavaScript...я промолчу..."
  when "java"
    puts " Java? А когда научат варить кофе ?"
  when "c++"
    puts " Плюсы c++ ? ++ "
  else
    puts "Интересный выбор, но Ruby лучше!"
  end
end

# Запрос команды на языке Ruby
puts "Введи команду на Ruby:"
ruby_command = gets.chomp

begin
  # Выполнение команды Ruby
  puts "Результат выполнения команды Ruby:"
  eval(ruby_command)
rescue StandardError => e
  puts "Ошибка выполнения команды Ruby: #{e.message}"
end

# Запрос команды операционной системы
puts "Введи команду операционной системы:"
os_command = gets.chomp

begin
  # Выполнение команды операционной системы
  puts "Результат выполнения команды операционной системы:"
  system(os_command)
rescue StandardError => e
  puts "Ошибка выполнения команды операционной системы: #{e.message}"
end
