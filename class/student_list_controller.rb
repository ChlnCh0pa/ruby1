require_relative 'db/students_list_DB'
require_relative 'student_short'
require_relative 'student'
require_relative 'data_list_student_short'
require_relative 'students_list_json'
require_relative 'students_list_yaml'
require_relative 'students_list'
require 'pg'
require_relative 'strategy_list_file'

class StudentListController
  attr_accessor :view
  attr_reader :students_list

  def initialize(view)
    @view = view
    @students_list = load_students_from_db
  end

  def load_students_from_db
    begin
      db_params = { dbname: 'students', user: 'postgres', password: '123', port: 5432, host: 'localhost' }
      conn = PG.connect(db_params)
      result = conn.exec('SELECT * FROM student')
      students = result.map do |row|
        Student.new(
          id: row['id'].to_i,
          surname: row['surname'],
          name: row['name'],
          patronymic: row['patronymic'],
          git: row['git'],
          email: row['email'],
          phone: row['phone'],
          telegram: row['telegram']
        )
      end
      puts "Loaded students: #{students.inspect}"  # Debug print
      students
    rescue PG::Error => e
      FXMessageBox.error(@view, MBOX_OK, "Ошибка базы данных", "Не удалось загрузить данные: #{e.message}")
      []
    ensure
      conn.close if conn
    end
  end

  def save_student_to_db(student)
    begin
      db_params = { dbname: 'students', user: 'postgres', password: '123', port: 5432, host: 'localhost' }
      conn = PG.connect(db_params)
      conn.exec_params(
        "INSERT INTO student (surname, name, patronymic, git, email, phone, telegram) VALUES ($1, $2, $3, $4, $5, $6, $7)",
        [student.surname, student.name, student.patronymic, student.git, student.email, student.phone, student.telegram]
      )
    rescue PG::Error => e
      FXMessageBox.error(@view, MBOX_OK, "Ошибка базы данных", "Не удалось сохранить студента: #{e.message}")
    ensure
      conn.close if conn
    end

    # Обновляем список студентов после добавления
    @students_list = load_students_from_db
  end

  def update_student_in_db(student)
    begin
      db_params = { dbname: 'students', user: 'postgres', password: '123', port: 5432, host: 'localhost' }
      conn = PG.connect(db_params)
      puts "Executing UPDATE for student: #{student.inspect}"  # Debug print
      conn.exec_params(
        "UPDATE student SET surname = $1, name = $2, patronymic = $3, git = $4, email = $5, phone = $6, telegram = $7 WHERE id = $8",
        [student.surname, student.name, student.patronymic, student.git, student.email, student.phone, student.telegram, student.id]
      )
    rescue PG::Error => e
      FXMessageBox.error(@view, MBOX_OK, "Ошибка базы данных", "Не удалось обновить студента: #{e.message}")
    ensure
      conn.close if conn
    end

    # Обновляем список студентов после редактирования
    @students_list = load_students_from_db
  end

  def update_student_field(student, field, new_value)
    begin
      db_params = { dbname: 'students', user: 'postgres', password: '123', port: 5432, host: 'localhost' }
      conn = PG.connect(db_params)
      puts "Executing UPDATE for student #{field}: #{student.inspect}"  # Debug print
      conn.exec_params(
        "UPDATE student SET #{field} = $1 WHERE id = $2",
        [new_value, student.id]
      )
      student.instance_variable_set("@#{field}", new_value)
    rescue PG::Error => e
      FXMessageBox.error(@view, MBOX_OK, "Ошибка базы данных", "Не удалось обновить #{field} студента: #{e.message}")
    ensure
      conn.close if conn
    end
  end

  def delete_student_from_db(student_id)
    begin
      db_params = { dbname: 'students', user: 'postgres', password: '123', port: 5432, host: 'localhost' }
      conn = PG.connect(db_params)
      puts "Executing DELETE for student ID: #{student_id}"  # Debug print
      conn.exec_params("DELETE FROM student WHERE id = $1", [student_id])
    rescue PG::Error => e
      FXMessageBox.error(@view, MBOX_OK, "Ошибка базы данных", "Не удалось удалить студента: #{e.message}")
    ensure
      conn.close if conn
    end

    # Обновляем список студентов после удаления
    @students_list = load_students_from_db
  end

  def filter_students(git_filter, email_filter, phone_filter, telegram_filter)
    @students_list.select do |student|
      match = true

      # Фильтр по гиту
      match &&= (git_filter == 1 && student.git.nil?) || (git_filter == 2 && !student.git.nil?)

      # Фильтр по почте
      match &&= (email_filter == 1 && student.email.nil?) || (email_filter == 2 && !student.email.nil?)

      # Фильтр по телефону
      match &&= (phone_filter == 1 && student.phone.nil?) || (phone_filter == 2 && !student.phone.nil?)

      # Фильтр по телеграмму
      match &&= (telegram_filter == 1 && student.telegram.nil?) || (telegram_filter == 2 && !student.telegram.nil?)

      match
    end
  end
end