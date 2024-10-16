require_relative 'student'

# Создание объектов класса Student
student_Afganiy = Student.new(
  '001',
  'Afganiy',
  'Oleg',
  'Ivanovich',
  '+79186999560',
  '@afganiyniy',
  'afganiy@mail.com',
  'github.com/afganiy'
)

student_Leman = Student.new(
  '002',
  'Leman',
  'Russ',
  'Petrovich',
  '+79123456789',
  '@lemanz',
  nil,
  'github.com/prospero'
)

student_Sangviniy = Student.new(
  '003',
  'Sangviniy',
  'Sasha',
  'Imperovich',
  '+79186999560',
  '@obidno',
  nil,
  'github.com/imperovich'
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
