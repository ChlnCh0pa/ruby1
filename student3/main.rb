require_relative 'base_student'
require_relative 'student'
require_relative 'student_short'


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

student_short_info = "Agronom Agropromovich Dunedain; https://github.com/elessar; agronome@rivendel.com, +79991234567, @deunedain_agropmrop"

student_short_from_info = StudentShort.new(nil, 3, student_short_info)


puts student1.to_s
puts student2.to_s
puts student1.get_info
puts student2.get_info
puts student_short_from_info.to_s
