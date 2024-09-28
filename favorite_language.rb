# Получение имени пользователя текущей сессии 
name = ENV['USERNAME']

if name.nil?
  puts "Не удалось получить имя пользователя."
  exit
end

# Приветствие с использованием форматирования строки
puts "Привет, #{name}!"

# Спросим у пользователя о его любимом языке программирования
puts "Какой твой любимый язык программирования?"
favorite_lang = gets.chomp

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
