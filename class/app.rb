require 'fox16'
require 'ostruct'
require 'pg'
include Fox
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/db/students_list_DB.rb'
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/student_short.rb'
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/student.rb'
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/Data_list_student_short.rb'
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/students_list_json.rb'
require_relative 'C:/Users/Sergey/AppData/Local/GitHubDesktop/ruby/class/students_list_yaml.rb'

class MainApp < FXMainWindow
  def initialize(app)
    super(app, "Студентики", width: 1000, height: 600)


    tab_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Создаем первую вкладку
    create_student_tab(tab_book, "Список студентов")
  end

  private

  def create_student_tab(tab_book, title)

    tab_item = FXTabItem.new(tab_book, title, nil)


    content_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y,
                                      padLeft: 10, padRight: 10, padTop: 10, padBottom: 10,
                                      hSpacing: 5, vSpacing: 5)

 
    filter_frame = FXHorizontalFrame.new(content_frame, LAYOUT_FILL_X)

    surname_frame = FXVerticalFrame.new(filter_frame, LAYOUT_FILL_Y)
    FXLabel.new(surname_frame, "Фамилия и инициалы:")


    git_frame = FXVerticalFrame.new(filter_frame, LAYOUT_FILL_Y)
    FXLabel.new(git_frame, "Гит:")
    @git_combo = FXComboBox.new(git_frame, 10, nil, 0, COMBOBOX_STATIC | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_Y)
    @git_combo.appendItem("Не важно")
    @git_combo.appendItem("Да")
    @git_combo.appendItem("Нет")
    @git_combo.currentItem = 0


    email_frame = FXVerticalFrame.new(filter_frame, LAYOUT_FILL_Y)
    FXLabel.new(email_frame, "Почта:")
    @email_combo = FXComboBox.new(email_frame, 10, nil, 0, COMBOBOX_STATIC | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_Y)
    @email_combo.appendItem("Не важно")
    @email_combo.appendItem("Да")
    @email_combo.appendItem("Нет")
    @email_combo.currentItem = 0


    phone_frame = FXVerticalFrame.new(filter_frame, LAYOUT_FILL_Y)
    FXLabel.new(phone_frame, "Телефон:")
    @phone_combo = FXComboBox.new(phone_frame, 10, nil, 0, COMBOBOX_STATIC | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_Y)
    @phone_combo.appendItem("Не важно")
    @phone_combo.appendItem("Да")
    @phone_combo.appendItem("Нет")
    @phone_combo.currentItem = 0

  
    telegram_frame = FXVerticalFrame.new(filter_frame, LAYOUT_FILL_Y)
    FXLabel.new(telegram_frame, "Телеграмм:")
    @telegram_combo = FXComboBox.new(telegram_frame, 10, nil, 0, COMBOBOX_STATIC | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_Y)
    @telegram_combo.appendItem("Не важно")
    @telegram_combo.appendItem("Да")
    @telegram_combo.appendItem("Нет")
    @telegram_combo.currentItem = 0

 
    filter_button = FXButton.new(content_frame, "Применить фильтр")

   
    reset_button = FXButton.new(content_frame, "Сбросить фильтр")

 
    @table = FXTable.new(content_frame, nil, 0, LAYOUT_FILL_X | LAYOUT_FILL_Y | TABLE_COL_SIZABLE | TABLE_ROW_SIZABLE)
    @table.setTableSize(5, 6)  


    @table.connect(SEL_SELECTED) do
      puts "Строка выбрана: #{@table.currentRow}" 
      update_button_states
    end

    @table.setFocus


    control_frame = FXHorizontalFrame.new(content_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    add_button = FXButton.new(control_frame, "Добавить")
    @edit_button = FXButton.new(control_frame, "Изменить")
    @delete_button = FXButton.new(control_frame, "Удалить")
    update_button = FXButton.new(control_frame, "Обновить")


    pagination_frame = FXHorizontalFrame.new(content_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    @prev_button = FXButton.new(pagination_frame, "Назад")
    @next_button = FXButton.new(pagination_frame, "Вперед")


    @page_label = FXLabel.new(pagination_frame, "Страница 1 из 1")


    @students = load_students_from_db
    @current_page = 0
    @sort_column = nil
    @sort_order = :asc
    @original_students = @students.dup

    set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)


    update_table(@current_page)


    filter_button.connect(SEL_COMMAND) do
      filter_students
    end

    reset_button.connect(SEL_COMMAND) do
      @students = @original_students.dup
      set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)
      update_table(@current_page)
      reset_filters
    end

    add_button.connect(SEL_COMMAND) do
      add_student
    end

    @edit_button.connect(SEL_COMMAND) do
      edit_student
    end

    @delete_button.connect(SEL_COMMAND) do
      delete_student
    end

    update_button.connect(SEL_COMMAND) do
      filter_students
    end

    @prev_button.connect(SEL_COMMAND) do
      if @current_page > 0
        @current_page -= 1
        update_table(@current_page)
      end
    end

    @next_button.connect(SEL_COMMAND) do
      if (@current_page + 1) * 5 < @students.size
        @current_page += 1
        update_table(@current_page)
      end
    end


    update_button_states
  end

  def load_students_from_db
    begin
      db_params = { dbname: 'students', user: 'postgres', password: '123', port: 5432, host: 'localhost' }
      students_list_db = DatabaseHandler.create(db_params)
      students = students_list_db.get_k_n_student_short_list(1, 100).elements


      students.dup
    rescue PG::Error => e
      FXMessageBox.error(self, MBOX_OK, "Ошибка базы данных", "Не удалось загрузить данные: #{e.message}")
      []
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
      puts "Студент успешно добавлен в базу данных: #{student.surname} #{student.name}"
    rescue PG::Error => e
      FXMessageBox.error(self, MBOX_OK, "Ошибка базы данных", "Не удалось сохранить студента: #{e.message}")
    ensure
      conn.close if conn
    end
  end

  def update_student_in_db(student)
    begin
      db_params = { dbname: 'students', user: 'postgres', password: '123', port: 5432, host: 'localhost' }
      conn = PG.connect(db_params)
      conn.exec_params(
        "UPDATE student SET surname = $1, name = $2, patronymic = $3, git = $4, email = $5, phone = $6, telegram = $7 WHERE id = $8",
        [student.surname, student.name, student.patronymic, student.git, student.email, student.phone, student.telegram, student.id]
      )
      puts "Студент успешно обновлен в базе данных: #{student.surname} #{student.name}"
    rescue PG::Error => e
      FXMessageBox.error(self, MBOX_OK, "Ошибка базы данных", "Не удалось обновить студента: #{e.message}")
    ensure
      conn.close if conn
    end
  end

  def delete_student_from_db(student_id)
    begin
      db_params = { dbname: 'students', user: 'postgres', password: '123', port: 5432, host: 'localhost' }
      conn = PG.connect(db_params)
      conn.exec_params("DELETE FROM student WHERE id = $1", [student_id])
      puts "Студент успешно удален из базы данных: ID #{student_id}"
    rescue PG::Error => e
      FXMessageBox.error(self, MBOX_OK, "Ошибка базы данных", "Не удалось удалить студента: #{e.message}")
    ensure
      conn.close if conn
    end
  end

  def set_table_params(column_names, whole_entities_count)
    display_names = {
      'name' => 'ФИО',
      'git' => 'Git',
      'email' => 'Почта',
      'phone' => 'Телефон',
      'telegram' => 'Telegram'
    }

    @table.setColumnText(0, "№")

    column_names.each_with_index do |name, id|
      display_name = display_names[name] || name
      @table.setColumnText(id + 1, display_name)
    end


    @table.setColumnWidth(0, 30)   # №
    @table.setColumnWidth(1, 200)  # ФИО
    @table.setColumnWidth(2, 150)  # Git
    @table.setColumnWidth(3, 200)  # Почта
    @table.setColumnWidth(4, 150)  # Телефон
    @table.setColumnWidth(5, 150)  # Telegram
  end

  def update_table(page)
    start_index = page * 5
    end_index = [start_index + 5, @students.size].min

 
    set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)

  
    @table.clearItems
    @table.setTableSize(end_index - start_index, 6) 


    (0...(end_index - start_index)).each do |row|
      student = @students[start_index + row]

      @table.setItemText(row, 0, (start_index + row + 1).to_s)  # Номер строки
      @table.setItemText(row, 1, student.surname_initials || "Не указано")  # ФИО
      @table.setItemText(row, 2, student.git || "Не указано")  # Git
      @table.setItemText(row, 3, student.email || "Не указано")  # Почта
      @table.setItemText(row, 4, student.phone || "Не указано")  # Телефон
      @table.setItemText(row, 5, student.telegram || "Не указано")  # Telegram


      @table.setItemJustify(row, 2, FXTableItem::LEFT | TEXT_WORDWRAP)
    end

    total_pages = (@students.size / 5.0).ceil
    @page_label.text = "Страница #{page + 1} из #{total_pages}"
  end

  def filter_students
    @students = @original_students.select do |student|
      match = true

 
      if @git_combo.currentItem == 1 && student.git.nil?
        match = false
      elsif @git_combo.currentItem == 2 && !student.git.nil?
        match = false
      end

   
      if @email_combo.currentItem == 1 && student.email.nil?
        match = false
      elsif @email_combo.currentItem == 2 && !student.email.nil?
        match = false
      end


      if @phone_combo.currentItem == 1 && student.phone.nil?
        match = false
      elsif @phone_combo.currentItem == 2 && !student.phone.nil?
        match = false
      end

      if @telegram_combo.currentItem == 1 && student.telegram.nil?
        match = false
      elsif @telegram_combo.currentItem == 2 && !student.telegram.nil?
        match = false
      end

      match
    end

    @current_page = 0

    set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)

    # Обновляем таблицу
    update_table(@current_page)
  end

  def reset_filters
    @git_combo.currentItem = 0
    @email_combo.currentItem = 0
    @phone_combo.currentItem = 0
    @telegram_combo.currentItem = 0
  end

  def update_button_states
    selected_row = @table.currentRow
    if selected_row >= 0
      @edit_button.enable
      @delete_button.enable
    else
      @edit_button.disable
      @delete_button.disable
    end
  end

  def add_student
    dialog = FXDialogBox.new(self, "Добавить студента", DECOR_TITLE | DECOR_BORDER)
    dialog_frame = FXVerticalFrame.new(dialog, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Поля для ввода данных
    FXLabel.new(dialog_frame, "Фамилия:")
    surname_input = FXTextField.new(dialog_frame, 30)

    FXLabel.new(dialog_frame, "Имя:")
    name_input = FXTextField.new(dialog_frame, 30)

    FXLabel.new(dialog_frame, "Отчество:")
    patronymic_input = FXTextField.new(dialog_frame, 30)

    FXLabel.new(dialog_frame, "Git:")
    git_input = FXTextField.new(dialog_frame, 30)

    FXLabel.new(dialog_frame, "Почта:")
    email_input = FXTextField.new(dialog_frame, 30)

    FXLabel.new(dialog_frame, "Телефон:")
    phone_input = FXTextField.new(dialog_frame, 30)

    FXLabel.new(dialog_frame, "Telegram:")
    telegram_input = FXTextField.new(dialog_frame, 30)

   
    button_frame = FXHorizontalFrame.new(dialog_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    ok_button = FXButton.new(button_frame, "ОК", nil, dialog, FXDialogBox::ID_ACCEPT, BUTTON_INITIAL | BUTTON_DEFAULT | FRAME_RAISED | FRAME_THICK | LAYOUT_RIGHT)
    cancel_button = FXButton.new(button_frame, "Отмена", nil, dialog, FXDialogBox::ID_CANCEL, BUTTON_DEFAULT | FRAME_RAISED | FRAME_THICK | LAYOUT_RIGHT)

    if dialog.execute != 0
      # Проверяем обязательные поля (Фамилия, Имя, Отчество)
      if surname_input.text.empty? || name_input.text.empty? || patronymic_input.text.empty?
        FXMessageBox.error(self, MBOX_OK, "Ошибка", "Фамилия, имя и отчество обязательны для заполнения.")
        return  # Прерываем выполнение, если обязательные поля не заполнены
      end

      new_student = Student.new(
        id: @students.size + 1,  
        surname: surname_input.text,
        name: name_input.text,
        patronymic: patronymic_input.text,
        git: git_input.text.empty? ? nil : git_input.text,
        email: email_input.text.empty? ? nil : email_input.text,
        phone: phone_input.text.empty? ? nil : phone_input.text,
        telegram: telegram_input.text.empty? ? nil : telegram_input.text
      )

      save_student_to_db(new_student)

      @students << new_student
      @original_students = @students.dup

    
      update_table(@current_page)
    end
  end

  def edit_student
    selected_row = @table.currentRow
    puts "Выбрана строка: #{selected_row}" 
    return if selected_row < 0  

    student_index = @current_page * 5 + selected_row
    return if student_index >= @students.size  

    student = @students[student_index]
    puts "Редактируется студент: #{student.inspect}" 

    dialog = FXDialogBox.new(self, "Редактировать студента", DECOR_TITLE | DECOR_BORDER)
    dialog_frame = FXVerticalFrame.new(dialog, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    FXLabel.new(dialog_frame, "Фамилия:")
    surname_input = FXTextField.new(dialog_frame, 30, nil, 0, TEXTFIELD_NORMAL)
    surname_input.text = student.surname

    FXLabel.new(dialog_frame, "Имя:")
    name_input = FXTextField.new(dialog_frame, 30, nil, 0, TEXTFIELD_NORMAL)
    name_input.text = student.name

    FXLabel.new(dialog_frame, "Отчество:")
    patronymic_input = FXTextField.new(dialog_frame, 30, nil, 0, TEXTFIELD_NORMAL)
    patronymic_input.text = student.patronymic

    FXLabel.new(dialog_frame, "Git:")
    git_input = FXTextField.new(dialog_frame, 30, nil, 0, TEXTFIELD_NORMAL)
    git_input.text = student.git || ""

    FXLabel.new(dialog_frame, "Почта:")
    email_input = FXTextField.new(dialog_frame, 30, nil, 0, TEXTFIELD_NORMAL)
    email_input.text = student.email || ""

    FXLabel.new(dialog_frame, "Телефон:")
    phone_input = FXTextField.new(dialog_frame, 30, nil, 0, TEXTFIELD_NORMAL)
    phone_input.text = student.phone || ""

    FXLabel.new(dialog_frame, "Telegram:")
    telegram_input = FXTextField.new(dialog_frame, 30, nil, 0, TEXTFIELD_NORMAL)
    telegram_input.text = student.telegram || ""

    button_frame = FXHorizontalFrame.new(dialog_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    ok_button = FXButton.new(button_frame, "ОК", nil, dialog, FXDialogBox::ID_ACCEPT, BUTTON_INITIAL | BUTTON_DEFAULT | FRAME_RAISED | FRAME_THICK | LAYOUT_RIGHT)
    cancel_button = FXButton.new(button_frame, "Отмена", nil, dialog, FXDialogBox::ID_CANCEL, BUTTON_DEFAULT | FRAME_RAISED | FRAME_THICK | LAYOUT_RIGHT)

    result = dialog.execute
    puts "Диалог вернул: #{result}" 

    if result != 0
      if surname_input.text.strip.empty? || name_input.text.strip.empty? || patronymic_input.text.strip.empty?
        FXMessageBox.error(self, MBOX_OK, "Ошибка", "Фамилия, имя и отчество обязательны.")
        return
      end

  end
      student.surname = surname_input.text.strip
      student.name = name_input.text.strip
      student.patronymic = patronymic_input.text.strip
      student.git = git_input.text.strip.empty? ? nil : git_input.text.strip
      student.email = email_input.text.strip.empty? ? nil : email_input.text.strip
      student.phone = phone_input.text.strip.empty? ? nil : phone_input.text.strip
      student.telegram = telegram_input.text.strip.empty? ? nil : telegram_input.text.strip

      puts "Обновляем студента: #{student.inspect}" 
      update_student_in_db(student)
      refresh_students_list
    end
  end

  def delete_student
    selected_row = @table.currentRow
    puts "Выбрана строка для удаления: #{selected_row}" 
    return if selected_row < 0  

    student_index = @current_page * 5 + selected_row
    return if student_index >= @students.size  

    student = @students[student_index]
    puts "Удаляется студент: #{student.inspect}" 

    confirm = FXMessageBox.question(self, MBOX_YES_NO, "Подтверждение", "Удалить студента #{student.surname} #{student.name}?")
    return unless confirm == MBOX_CLICKED_YES

    delete_student_from_db(student.id)
    @students.delete_at(student_index)

    puts "Студент удален. Обновленный список: #{@students.inspect}"

    refresh_students_list
  end

  def refresh_students_list
    puts "Обновление таблицы..." 
    update_table(@current_page)

  def create
    super
  end
end

app = FXApp.new
main_window = MainApp.new(app)
main_window.show(PLACEMENT_SCREEN)
app.create
app.run