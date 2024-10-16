require_relative 'student'

# Создание объектов класса Student
student_Afganiy = Student.new(
  id: '001',
  last_name: 'Afganiy',
  first_name: 'Oleg',
  middle_name: 'Ivanovich',
  phone: '+79186999560',
  telegram: '@afganiyniy',
  email: 'afganiy@mail.com',
  git: 'https://github.com/afganiy/repo'
)

student_Leman = Student.new(
  id: '002',
  last_name: 'Leman',
  first_name: 'Russ',
  middle_name: 'Petrovich',
  phone: '+79123456789',
  telegram: '@lemanz',
  email: nil,
  git: 'https://github.com/prospero/repo'
)

student_Sangviniy = Student.new(
  id: '003',
  last_name: 'Sangviniy',
  first_name: 'Sasha',
  middle_name: 'Imperovich',
  phone: '+79186999560',
  telegram: '@obidno',
  email: nil,
  git: 'https://github.com/imperovich/repo'
)

# Метод для вывода информации о студенте
def display_student_info(student)
  puts "ID: #{student.id}"
  puts "Фамилия: #{student.last_name}"
  puts "Имя: #{student.first_name}"
  puts "Отчество: #{student.middle_name}"
  puts "Телефон: #{student.phone}"
  puts "Телеграм: #{student.telegram}"
  puts "Почта: #{student.email}"
  puts "Гит: #{student.git}"
  puts "-" * 20
end

# Вывод информации о каждом студенте
display_student_info(student_Afganiy)
display_student_info(student_Leman)
display_student_info(student_Sangviniy)
