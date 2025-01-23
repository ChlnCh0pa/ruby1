require_relative 'data_list'
require_relative 'data_table'

class DataListStudentShort < DataList
  private
  def specific_names
    ['Фамилия и инициалы', 'GitHub', 'Контакты']
  end
  def specific_data(item)
    [item.surname_initials, item.git, item.contact]
  end
end