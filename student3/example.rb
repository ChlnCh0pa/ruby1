# Абстрактный класс Medicine
class Medicine
  def prepare
    measure_ingredients
    mix
    package
    label
  end

  # Абстрактные методы
  def measure_ingredients
    raise NotImplementedError, 'Этот метод должен быть переопределен в подклассе'
  end

  def mix
    raise NotImplementedError, 'Этот метод должен быть переопределен в подклассе'
  end

  def package
    raise NotImplementedError, 'Этот метод должен быть переопределен в подклассе'
  end

  def label
    raise NotImplementedError, 'Этот метод должен быть переопределен в подклассе'
  end
end

# Конкретный класс Tablet
class Tablet < Medicine
  def measure_ingredients
    puts 'Измерение ингредиентов для таблеток'
  end

  def mix
    puts 'Смешивание ингредиентов для таблеток'
  end

  def package
    puts 'Упаковка таблеток в блистерные упаковки'
  end

  def label
    puts 'Маркировка упаковок таблеток'
  end
end

# Конкретный класс Syrup
class Syrup < Medicine
  def measure_ingredients
    puts 'Измерение ингредиентов для сиропа'
  end

  def mix
    puts 'Смешивание ингредиентов для сиропа'
  end

  def package
    puts 'Розлив сиропа по бутылкам'
  end

  def label
    puts 'Маркировка бутылок с сиропом'
  end
end


def main
  tablet = Tablet.new
  syrup = Syrup.new

  puts 'Приготовление таблеток:'
  tablet.prepare
  puts "\nПриготовление сиропа:"
  syrup.prepare
end

puts main