
if ARGV.empty?
  puts "Пожалуйста, укажите своё имя как аргумент программы."
  exit
end


name = ARGV[0]
puts "Привет, #{name}!"

$stdin = STDIN


puts "Какой твой любимый язык программирования?"
favorite_lang = $stdin.gets.chomp


if favorite_lang == "ruby"
  puts "#{name}, ты подлиза!"
else
  puts "#{name}, скоро ты полюбишь Ruby!"
  

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
