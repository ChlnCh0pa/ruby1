require_relative 'base_student'
require_relative 'student'
require_relative 'student_short'

student1 = Student.new(
  id: '1',
  name: 'Leaman',
  surname: 'Russ',
  patronymic: 'Slonovich',
  git: 'github.com/prospero',  
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
  git: 'github.com/bulba',  
  telegram: '@sumkin'
)

student_short_info = "Agronom Agropromovich Dunedain; github.com/elessar; agronome@rivendel.com, +79991234567, @deunedain_agropmrop"
student_short_from_info = StudentShortInfo.new_from_string(id: 3, str: student_short_info)

puts student1.to_s
puts student2.to_s
puts student1.get_info
puts student2.get_info

puts student_short_from_info.to_s
