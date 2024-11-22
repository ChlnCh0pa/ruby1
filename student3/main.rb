require_relative 'student'

student1 = Student.new(
  id: '1',
  name: 'Leman',
  surname: 'Russ',
  patronymic: 'Slonovich',
  git: 'https://github.com/prospero',
  email: 'lemanruss@yandex.ru',
  phone: '+79186654123',
  telegram: '@russkiy_volk'
)

student2 = Student.new(
  id: '2',
  name: 'Bulba',
  surname: 'Sumkin',
  patronymic: 'Bangovich',
  email: 'torba_na_kruche@shir.ru',
  git: 'https://github.com/bulba',
  telegram: '@sumkin'
)
# student3_data = "3, Agronom, Agropromovich, Dunedain, https://github.com/elessar, agronomexample.com, +79991234567, @deunedain_agropmrop"
# student3 = Student.from_string(student3_data)

# Вывод объектов

# begin
# puts student1.to_s
# rescue => e
  # puts e.message
# end

puts student1
puts student2
puts student1.get_info
puts student2.get_info