require_relative 'data_list'
require_relative 'data_table'
class DataListStudentShort < DataList
  def get_names
    ['Surname and initials', 'GitHub', 'Contacts']
  end

  def get_data
    data_with_indices = @data.each_with_index.map do |student, index|
      [index + 1, student.surname_initials, student.git, student.contact]
    end
    DataTable.new(data_with_indices)
  end
end


