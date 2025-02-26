require_relative 'binary_tree'
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
  telegram: '@russkiy_volk',
  birth_date: Date.new(1998, 5, 15)
)

student2 = Student.new(
  id: '2',
  name: 'Bulba',
  surname: 'Sumkin',
  patronymic: 'Bangovich',
  email: 'torba_na_kruche@shir.ru',
  git: 'github.com/bulba',
  telegram: '@sumkin',
  birth_date: Date.new(2003, 5, 20)
)

student3 = Student.new(
  id: '10',
  name: 'Baralgin',
  patronymic: 'Dimedrolovich',
  surname:'Grebneshchikov',
  git: 'github.com/grebenb',
  telegram: '@agropromlox',
  birth_date: Date.new(1989, 10, 5)
  )

student_from_student = StudentShortInfo.new_from_student(student3)
student_short_info = "Agronom A.D.; github.com/elessar; agronome@rivendel.com, +79991234567, @deunedain_agropmrop"
student_short_from_info = StudentShortInfo.new_from_string(id: 3, str: student_short_info)
student4 = StudentShortInfo.new_from_student(student3)

puts student1.to_s
puts student2.to_s
student3.set_contacts(telegram: "@agropromichnelox")
puts student1.to_s
student1.validate_git_and_contact




puts student2.get_info.to_s

puts "\n Краткая инфа:\n #{student_short_from_info.to_s},\n #{student_from_student}  \n\n"



puts student1.surname_initials
puts "#{student3.set_contacts}\n\n"

tree = BinaryTree.new
tree.add(student1)
tree.add(student2)
tree.add(student3)
tree.each { |student| puts student.birth_date }
puts tree.map { |s| s.surname }
puts tree.count 
