# Проверка, передан ли аргумент для имени пользователя
if ARGV.empty?
  puts "Пожалуйста, укажите своё имя как аргумент программы."
  exit
end

# Получение имени пользователя из аргумента командной строки
name = ARGV[0]

puts "Привет, #{name}!"

# Открываем стандартный поток ввода, чтобы использовать gets после аргументов командной строки
$stdin = STDIN

# Спросим у пользователя о его любимом языке программирования
puts "Какой твой любимый язык программирования?"
favorite_lang = $stdin.gets.chomp

# Ответы в зависимости от языка
if favorite_lang == "ruby"
  puts "#{name}, ты подлиза!"
else
  puts "#{name}, скоро ты полюбишь Ruby!"
  
  # Комментарии для различных языков
  case favorite_lang
  when "python"
    puts "Python — отличное начало!"
  when "javascript"
    puts "JavaScript... я промолчу..."
  when "java"
    puts "Java? А когда научат варить кофе?"
  when "c++"
    puts "C++? Плюсы так и манят!"
  else
    puts "Интересный выбор, но Ruby лучше!"
  end
end

# Запрос команды на языке Ruby
puts "Введи команду на Ruby:"
ruby_command = $stdin.gets.chomp

begin
  # Выполнение команды Ruby
  puts "Результат выполнения команды Ruby:"
  eval(ruby_command)
rescue StandardError => e
  puts "Ошибка выполнения команды Ruby: #{e.message}"
end

# Запрос команды операционной системы
puts "Введи команду операционной системы:"
os_command = $stdin.gets.chomp

begin
  # Выполнение команды операционной системы
  puts "Результат выполнения команды операционной системы:"
  system(os_command)
rescue StandardError => e
  puts "Ошибка выполнения команды операционной системы: #{e.message}"
end

# ruby commands.rb Sergey