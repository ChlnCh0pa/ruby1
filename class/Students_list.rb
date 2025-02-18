require_relative 'data_list'
require_relative 'data_table'
require_relative 'student_short'
require_relative 'data_list_student_short'
require_relative 'student'
require_relative 'base_student'
require_relative 'strategy_list_file'
require 'json'
require 'yaml'

class StudentsList
  attr_reader :file_path, :file_strategy

  def initialize(file_path, file_strategy)
    @file_path = file_path
    @file_strategy = file_strategy
  end

  def read
    @file_strategy.read(@file_path) || []
  end

  def write (students)
    @file_strategy.write(@file_path, students)
  end

  def find_student_by_id(id)
    students_data = read
    student_data = students_data.find { |student| student[:id] == id }
    raise "Студент с ID #{id} не найден" unless student_data

    Student.new(student_data)
  end

  def get_k_n_student_short_list(k, n, data_list = nil)
    students_data = read
    total_students = students_data.size

    start_index = (k - 1) * n
    end_index = [start_index + n - 1, total_students - 1].min

    unless data_list.is_a?(Data_list_student_short)
      data_list = Data_list_student_short.new([])

    selected_students = students_data[start_index..end_index].map do |student_data|
      StudentShortInfo.new_from_student(Student.new(student_data))
    end

    data_list.elements = selected_students
    data_list
  end

  def sort_by_surname_and_initials
    students_data = read
    sorted_students = students_data.sort_by do |student|
      "#{student[:surname]} #{student[:name][0]}.#{student[:patronymic][0]}."
    end
    write (sorted_students)
    sorted_students
  end

 def add_student(new_student)
  students_data = read
  if students_data.any? { |student| student == new_student }
    raise "Студент с такими данными уже существует!"
  end

  max_id = students_data.map(&:id).max || 0
  new_id = max_id + 1
  new_student_with_id = Student.new(
    id: new_id,
    surname: new_student.surname,
    name: new_student.name,
    patronymic: new_student.patronymic,
    git: new_student.git,
    phone: new_student.phone,
    email: new_student.email,
    telegram: new_student.telegram
  )

  students_data << new_student_with_id
  write(students_data)

  new_id
end




    def replace_student_by_id(id, updated_student)
  students_data = read
  index = students_data.find_index { |student| student[:id] == id }
  raise "Студент с ID #{id} не найден" unless index
  students_data.each_with_index do |student, i|
    next if i == index 
    if Student.new(student) == updated_student
      raise "Студент с такими данными уже существует!"
    end
  end
  students_data[index] = {
    id: id,
    surname: updated_student.surname,
    name: updated_student.name,
    patronymic: updated_student.patronymic,
    git: updated_student.git,
    contact: updated_student.phone || updated_student.telegram || updated_student.email
  }
end

    write (students_data)
  end

  def get_student_short_count
    read.size
  end

  def delete_student_by_id(student_id)
    students_data = read
    student = students_data.find { |s| s[:id] == student_id }
    if student
      students_data.delete(student)
      write (students_data)
    else
      raise "Студент с ID = #{student_id} не найден"
    end
  end
end