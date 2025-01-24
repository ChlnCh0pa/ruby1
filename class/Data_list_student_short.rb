require_relative 'data_list'
require_relative 'data_table'
require_relative 'student_short'

class Data_list_student_short < Data_list
  def attribute_names
    ["Инициалы", "Git", "Контакты"]
  end

  def extract_attributes(student)
    [student.surname_initials, student.git, student.contact]
  end
end