require 'pg'
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/student.rb'
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/Data_list.rb'
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/base_student.rb'
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/Data_table.rb'
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/strategy_list_file.rb'
require 'json'
require 'yaml'

class DatabaseHandler
  
  @@instance = nil

  def initialize(db_params)
    @conn = PG.connect(db_params)
    @students_cache = {}
  end

  # Метод для получения единственного экземпляра
  def self.instance(db_params = nil)
    @@instance ||= new(db_params)
  end

  def close
    @conn.close
  end

  def read_students
    file_strategy.read(file_path)
  end

  def write_students(students)
    file_strategy.write(file_path, students)
  end
  
  def get_student_by_id(id)
    result = @conn.exec_params('SELECT * FROM student WHERE id = $1', [id])
    if result.ntuples > 0
      student_data = result[0]
      Student.new(
        id: student_data['id'],
        surname: student_data['surname'],
        name: student_data['name'],
        patronymic: student_data['patronymic'],
        git: student_data['git'],
        phone: student_data['phone'],
        email: student_data['email'],
        telegram: student_data['telegram']
      )
    else
      raise "Студент с ID #{id} не найден"
    end
  end

  def get_k_n_student_short_list(k, n)
    offset = (k - 1) * n
    result = @conn.exec_params('SELECT * FROM student LIMIT $1 OFFSET $2', [n, offset])

    students = result.map do |row|
      StudentShortInfo.new_from_student(
        Student.new(
          id: row['id'],
          surname: row['surname'],
          name: row['name'],
          patronymic: row['patronymic'],
          git: row['git'],
          phone: row['phone'],
          email: row['email'],
          telegram: row['telegram']
        )
      )
    end

    Data_list_student_short.new(students)
  end

  def add_student(new_student)
    if student_exists?(new_student)
      raise "Студент с такими данными уже существует!"
    end

    result = @conn.exec_params(
      'INSERT INTO student (surname, name, patronymic, git, phone, email, telegram) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id',
      [
        new_student.surname,
        new_student.name,
        new_student.patronymic,
        new_student.git,
        new_student.phone,
        new_student.email,
        new_student.telegram
      ]
    )
    
    # Кэшируем студента для быстрого поиска по ранее добавленным данным
    @students_cache[new_student.git] = new_student
    
    result[0]['id'].to_i
  end

  def replace_student_by_id(id, updated_student)
    @conn.exec_params(
      'UPDATE student SET surname = $1, name = $2, patronymic = $3, git = $4, phone = $5, email = $6, telegram = $7 WHERE id = $8',
      [
        updated_student.surname,
        updated_student.name,
        updated_student.patronymic,
        updated_student.git,
        updated_student.phone,
        updated_student.email,
        updated_student.telegram,
        id
      ]
    )
  end

  def delete_student_by_id(id)
    @conn.exec_params('DELETE FROM student WHERE id = $1', [id])
  end

  def get_student_count
    result = @conn.exec('SELECT COUNT(*) FROM student')
    result[0]['count'].to_i
  end
  
  private
  

  def student_exists?(new_student)
    @students_cache.key?(new_student.git) || existing_student_in_db?(new_student)
  end

  def existing_student_in_db?(new_student)
    result = @conn.exec_params(
      'SELECT COUNT(*) FROM student WHERE git = $1 OR email = $2',
      [new_student.git, new_student.email]
    )
    result[0]['count'].to_i > 0
  end
end
