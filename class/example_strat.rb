# Интерфейс стратегии
class WeaponStrategy
  def attack
    raise NotImplementedError, 'Вы должны реализовать метод attack'
  end
end

# Конкретная стратегия 1 - атака с помощью меча
class SwordAttack < WeaponStrategy
  def attack
    puts 'Атака мечом!'
  end
end

# Конкретная стратегия 2 - атака с помощью лука
class BowAttack < WeaponStrategy
  def attack
    puts 'Атака луком!'
  end
end

# Конкретная стратегия 3 - атака с помощью топора
class AxeAttack < WeaponStrategy
  def attack
    puts 'Атака топором!'
  end
end

# Контекст, который использует стратегию
class Character
  def initialize(weapon_strategy)
    @weapon_strategy = weapon_strategy
  end

  def attack_enemy
    @weapon_strategy.attack
  end
end

fedor = Character.new(SwordAttack.new)
fedor.attack_enemy  # Вывод: Атака мечом!

lagovas = Character.new(BowAttack.new)
lagovas.attack_enemy  # Вывод: Атака луком!

givi = Character.new(AxeAttack.new)
givi.attack_enemy  # Вывод: Атака топором!
