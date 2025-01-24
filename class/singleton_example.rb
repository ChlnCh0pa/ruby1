
class Sauron
  @instance = nil

  private_class_method :new


  def self.instance
    @instance ||= new
  end
  def rule
    "One Ring to rule them all..."
  end
end


puts "Создаем первый экземпляр Саурона:"
sauron1 = Sauron.instance
puts sauron1.rule

puts "\nСоздаем второй экземпляр Саурона:"
sauron2 = Sauron.instance

puts "\nПроверяем, что это один и тот же объект:"
puts "sauron1.object_id == sauron2.object_id: #{sauron1.object_id == sauron2.object_id}"
