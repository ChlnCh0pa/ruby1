# Проверка, передан ли аргумент для имени пользователя
if ARGV.empty?
  puts "Пожалуйста, укажите своё имя как аргумент программы."
  exit
end

# Получение имени пользователя из аргумента командной строки
name = ARGV[0]

# Приветствие с использованием форматирования строки
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
# ruby favorite_language.rb Sergey
