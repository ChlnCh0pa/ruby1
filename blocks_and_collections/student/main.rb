require_relative 'binary_tree'
require_relative 'base_student'
require_relative 'student'



student1 = Student.new(
  id: '1',
  name: 'Leaman', 
  surname: 'Russ',
  patronymic: 'Slonovich',
  git: 'github.com/prospero',
  email: 'lemanruss@yandex.ru',
  phone: '+79186654123',
  telegram: '@russkiy_volk',
  birth_date: Date.new(1999, 5, 15)
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
  birth_date: Date.new(1119, 10, 5)
  )

tree = BinaryTree.new
tree.add(student1)
tree.add(student2)
tree.add(student3)
tree.each { |student| puts student.birth_date }
puts tree.map { |s| s.surname }
puts tree.count 



