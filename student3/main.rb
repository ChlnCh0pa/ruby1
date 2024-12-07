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

student3 = Student.new(
  id: '10',
  name: 'Baralgin',
  surname:'Grebneshchikov',
  patronymic: 'Dimedrolovich',
  git: 'github.com/grebenb',
  telegram: '@agropromlox'
  )

student_from_base_student = StudentShortInfo.new_from_base_student(student3)
student_short_info = "Agronom A.D.; github.com/elessar; agronome@rivendel.com, +79991234567, @deunedain_agropmrop"
student_short_from_info = StudentShortInfo.new_from_string(id: 3, str: student_short_info)
student4 = StudentShortInfo.new_from_base_student(student3)

puts student1.to_s
puts student2.to_s
student1.set_contacts(phone: '+79186654166', email: "new_email@example.com")
puts student1.to_s
student1.validate_git_and_contact




puts student2.get_info

puts "\n Краткая инфа:\n #{student_short_from_info.to_s},\n #{student_from_base_student}  \n\n"



# Вывод гитa, инициалов и контактов через отдельные методы объекта класса
puts student1.short_name
puts student1.short_info
puts student1.contact_info
