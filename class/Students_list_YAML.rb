require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'student'
require_relative 'Students_list'
require_relative 'strategy_list_file'
require 'yaml'

class Students_list_YAML < File_strategy
  def read(file_path)
    return [] unless File.exist?(file_path)
    YAML.load_file(file_path) || []
  rescue StandardError => e
    raise "Ошибка при чтении YAML файла: #{e.message}"
  end

  def write(file_path, data)
    File.open(file_path, 'w') { |file| file.write(data.to_yaml) }
  rescue StandardError => e
    raise "Ошибка при записи в YAML файл: #{e.message}"
  end
end