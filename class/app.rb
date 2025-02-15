require 'fox16'
include Fox

class MainApp < FXMainWindow
  def initialize(app)
    super(app, "Приложение со списком студентов", width: 1000, height: 600)
    @controller = StudentListController.new(self)
    @students = @controller.students_list
    @current_page = 0
    @original_students = @students.dup
    @selected_row = -1  # Инициализация выбранной строки

    # Создаем TabBook (контейнер для вкладок)
    tab_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Создаем первую вкладку
    create_student_tab(tab_book, "Список студентов")
  end

  private

  def set_table_params(column_names, whole_entities_count)
    display_names = {
      'name' => 'ФИО',
      'git' => 'Git',
      'email' => 'Почта',
      'phone' => 'Телефон',
      'telegram' => 'Telegram'
    }

    # Устанавливаем заголовок для колонки "№"
    @table.setColumnText(0, "№")

    # Устанавливаем заголовки для остальных колонок
    column_names.each_with_index do |name, id|
      display_name = display_names[name] || name
      @table.setColumnText(id + 1, display_name)
    end

    # Устанавливаем ширину колонок
    @table.setColumnWidth(0, 30)   # №
    @table.setColumnWidth(1, 200)  # ФИО
    @table.setColumnWidth(2, 150)  # Git
    @table.setColumnWidth(3, 200)  # Почта
    @table.setColumnWidth(4, 150)  # Телефон
    @table.setColumnWidth(5, 150)  # Telegram
  end

  def create_student_tab(tab_book, title)
    # Создаем вкладку (FXTabItem)
    tab_item = FXTabItem.new(tab_book, title, nil)

    # Создаем контейнер для вкладки (FXVerticalFrame)
    content_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL_X | LAYOUT_FILL_Y,
                                        padLeft: 10, padRight: 10, padTop: 10, padBottom: 10,
                                        hSpacing: 5, vSpacing: 5)

    # Область фильтрации
    filter_frame = FXHorizontalFrame.new(content_frame, LAYOUT_FILL_X)

    # Часть 1: Поле для ввода фамилии и инициалов
    surname_frame = FXVerticalFrame.new(filter_frame, LAYOUT_FILL_Y)
    FXLabel.new(surname_frame, "Фамилия и инициалы:")

    # Часть 2: Гит
    git_frame = FXVerticalFrame.new(filter_frame, LAYOUT_FILL_Y)
    FXLabel.new(git_frame, "Гит:")
    @git_combo = FXComboBox.new(git_frame, 10, nil, 0, COMBOBOX_STATIC | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_Y)
    @git_combo.appendItem("Не важно")
    @git_combo.appendItem("Да")
    @git_combo.appendItem("Нет")
    @git_combo.currentItem = 0

    # Часть 3: Почта
    email_frame = FXVerticalFrame.new(filter_frame, LAYOUT_FILL_Y)
    FXLabel.new(email_frame, "Почта:")
    @email_combo = FXComboBox.new(email_frame, 10, nil, 0, COMBOBOX_STATIC | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_Y)
    @email_combo.appendItem("Не важно")
    @email_combo.appendItem("Да")
    @email_combo.appendItem("Нет")
    @email_combo.currentItem = 0

    # Часть 4: Телефон
    phone_frame = FXVerticalFrame.new(filter_frame, LAYOUT_FILL_Y)
    FXLabel.new(phone_frame, "Телефон:")
    @phone_combo = FXComboBox.new(phone_frame, 10, nil, 0, COMBOBOX_STATIC | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_Y)
    @phone_combo.appendItem("Не важно")
    @phone_combo.appendItem("Да")
    @phone_combo.appendItem("Нет")
    @phone_combo.currentItem = 0

    # Часть 5: Телеграмм
    telegram_frame = FXVerticalFrame.new(filter_frame, LAYOUT_FILL_Y)
    FXLabel.new(telegram_frame, "Телеграмм:")
    @telegram_combo = FXComboBox.new(telegram_frame, 10, nil, 0, COMBOBOX_STATIC | FRAME_SUNKEN | FRAME_THICK | LAYOUT_FILL_Y)
    @telegram_combo.appendItem("Не важно")
    @telegram_combo.appendItem("Да")
    @telegram_combo.appendItem("Нет")
    @telegram_combo.currentItem = 0

    # Кнопка для применения фильтра
    filter_button = FXButton.new(content_frame, "Применить фильтр")
    filter_button.connect(SEL_COMMAND) do
      filter_students
    end

    # Кнопка для сброса фильтра
    reset_button = FXButton.new(content_frame, "Сбросить фильтр")
    reset_button.connect(SEL_COMMAND) do
      @students = @original_students.dup
      set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)
      update_table(@current_page)
      reset_filters
    end

    # Таблица для отображения студентов
    @table = FXTable.new(content_frame, nil, 0, TABLE_READONLY | LAYOUT_FILL_X | LAYOUT_FILL_Y | TABLE_COL_SIZABLE | TABLE_ROW_SIZABLE)
    @table.setTableSize(5, 6)  # 5 строк, 6 колонок: №, ФИО, Git, Почта, Телефон, Telegram

    # Устанавливаем параметры таблицы
    set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)

    # Область управления (кнопки)
    control_frame = FXHorizontalFrame.new(content_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    add_button = FXButton.new(control_frame, "Добавить")
    add_button.connect(SEL_COMMAND) do
      add_student
    end

    @edit_button = FXButton.new(control_frame, "Изменить")
    @edit_button.connect(SEL_COMMAND) do
      edit_student
    end

    @delete_button = FXButton.new(control_frame, "Удалить")
    @delete_button.connect(SEL_COMMAND) do
      delete_student
    end

    update_button = FXButton.new(control_frame, "Обновить")
    update_button.connect(SEL_COMMAND) do
      @students = @controller.students_list
      set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)
      update_table(@current_page)
    end

    # Кнопки для пагинации
    pagination_frame = FXHorizontalFrame.new(content_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    @prev_button = FXButton.new(pagination_frame, "Назад")
    @prev_button.connect(SEL_COMMAND) do
      @current_page -= 1 if @current_page > 0
      update_table(@current_page)
    end

    @next_button = FXButton.new(pagination_frame, "Вперед")
    @next_button.connect(SEL_COMMAND) do
      @current_page += 1 if (@current_page + 1) * 5 < @students.size
      update_table(@current_page)
    end

    # Текстовое поле для отображения текущей страницы и общего количества страниц
    @page_label = FXLabel.new(pagination_frame, "Страница 1 из 1")  # Инициализация @page_label

    # Обновляем таблицу после инициализации @page_label
    update_table(@current_page)

    # Обработчик событий для выделения строк в таблице
    @table.connect(SEL_SELECTED) do |sender, sel, data|
      puts "Row selected: #{data.row}"  # Debug print
      @selected_row = data.row + @current_page * 5  # Сохраняем выбранную строку с учетом текущей страницы
      update_button_states
    end

    # Инициализация состояния кнопок
    update_button_states
  end

  def update_table(page)
    return if page.nil? || page < 0

    @current_page = page
    start_index = page * 5
    end_index = [start_index + 5, @students.size].min

    # Устанавливаем параметры таблицы перед обновлением данных
    set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)

    # Очищаем таблицу
    @table.clearItems
    @table.setTableSize(end_index - start_index, 6)  # 6 колонок: №, ФИО, Git, Почта, Телефон, Telegram

    # Заполняем таблицу данными
    (0...(end_index - start_index)).each do |row|
      student = @students[start_index + row]

      @table.setItemText(row, 0, (start_index + row + 1).to_s)  # Номер строки
      @table.setItemText(row, 1, student.surname_initials || "Не указано")  # ФИО
      @table.setItemText(row, 2, student.git || "Не указано")  # Git
      @table.setItemText(row, 3, student.email || "Не указано")  # Почта
      @table.setItemText(row, 4, student.phone || "Не указано")  # Телефон
      @table.setItemText(row, 5, student.telegram || "Не указано")  # Telegram
    end

    # Обновляем информацию о странице
    total_pages = (@students.size / 5.0).ceil
    @page_label.text = "Страница #{page + 1} из #{total_pages}"
  end

  def filter_students
    git_filter = @git_combo.currentItem
    email_filter = @email_combo.currentItem
    phone_filter = @phone_combo.currentItem
    telegram_filter = @telegram_combo.currentItem

    @students = @controller.filter_students(git_filter, email_filter, phone_filter, telegram_filter)
    @current_page = 0

    # Устанавливаем параметры таблицы перед обновлением данных
    set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)

    # Обновляем таблицу
    update_table(@current_page)
  end

  def reset_filters
    @git_combo.currentItem = 0
    @email_combo.currentItem = 0
    @phone_combo.currentItem = 0
    @telegram_combo.currentItem = 0

    @students = @original_students.dup

    # Устанавливаем параметры таблицы перед обновлением данных
    set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)

    # Обновляем таблицу
    update_table(@current_page)
  end

  def update_button_states
    selected_rows = []
    (0...@table.numRows).each do |row|
      selected_rows << row if @table.rowSelected?(row)
    end

    if selected_rows.size == 1
      @edit_button.enable
      @delete_button.enable
    elsif selected_rows.size > 1
      @edit_button.disable
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

    # Кнопки "ОК" и "Отмена"
    button_frame = FXHorizontalFrame.new(dialog_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    ok_button = FXButton.new(button_frame, "ОК", nil, dialog, FXDialogBox::ID_ACCEPT, BUTTON_INITIAL | BUTTON_DEFAULT | FRAME_RAISED | FRAME_THICK | LAYOUT_RIGHT)
    cancel_button = FXButton.new(button_frame, "Отмена", nil, dialog, FXDialogBox::ID_CANCEL, BUTTON_DEFAULT | FRAME_RAISED | FRAME_THICK | LAYOUT_RIGHT)

    if dialog.execute != 0
      # Проверяем обязательные поля (Фамилия, Имя, Отчество)
      if surname_input.text.empty? || name_input.text.empty? || patronymic_input.text.empty?
        FXMessageBox.error(self, MBOX_OK, "Ошибка", "Фамилия, имя и отчество обязательны для заполнения.")
        return
      end

      # Создаем нового студента
      student = Student.new(
        surname: surname_input.text,
        name: name_input.text,
        patronymic: patronymic_input.text,
        git: git_input.text.empty? ? nil : git_input.text,
        email: email_input.text.empty? ? nil : email_input.text,
        phone: phone_input.text.empty? ? nil : phone_input.text,
        telegram: telegram_input.text.empty? ? nil : telegram_input.text
      )

      # Сохраняем студента в базу данных
      @controller.save_student_to_db(student)

      # Обновляем список студентов
      @students = @controller.students_list
      @original_students = @students.dup

      # Устанавливаем параметры таблицы перед обновлением данных
      set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)

      # Обновляем таблицу
      update_table(@current_page)
    end
  end

  def edit_student
    selected_row = @selected_row
    puts "Selected row for editing: #{selected_row}"  # Debug print
    return if selected_row < 0  # Если строка не выбрана, выходим

    student = @students[selected_row]
    puts "Editing student: #{student.inspect}"  # Debug print

    dialog = FXDialogBox.new(self, "Редактировать студента", DECOR_TITLE | DECOR_BORDER)
    dialog_frame = FXVerticalFrame.new(dialog, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    # Поля для ввода данных
    FXLabel.new(dialog_frame, "Фамилия:")
    surname_input = FXTextField.new(dialog_frame, 30)
    surname_input.text = student.surname

    FXLabel.new(dialog_frame, "Имя:")
    name_input = FXTextField.new(dialog_frame, 30)
    name_input.text = student.name

    FXLabel.new(dialog_frame, "Отчество:")
    patronymic_input = FXTextField.new(dialog_frame, 30)
    patronymic_input.text = student.patronymic

    FXLabel.new(dialog_frame, "Git:")
    git_input = FXTextField.new(dialog_frame, 30)
    git_input.text = student.git

    FXLabel.new(dialog_frame, "Почта:")
    email_input = FXTextField.new(dialog_frame, 30)
    email_input.text = student.email

    FXLabel.new(dialog_frame, "Телефон:")
    phone_input = FXTextField.new(dialog_frame, 30)
    phone_input.text = student.phone

    FXLabel.new(dialog_frame, "Telegram:")
    telegram_input = FXTextField.new(dialog_frame, 30)
    telegram_input.text = student.telegram

    # Кнопки "ОК" и "Отмена"
    button_frame = FXHorizontalFrame.new(dialog_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    ok_button = FXButton.new(button_frame, "ОК", nil, dialog, FXDialogBox::ID_ACCEPT, BUTTON_INITIAL | BUTTON_DEFAULT | FRAME_RAISED | FRAME_THICK | LAYOUT_RIGHT)
    cancel_button = FXButton.new(button_frame, "Отмена", nil, dialog, FXDialogBox::ID_CANCEL, BUTTON_DEFAULT | FRAME_RAISED | FRAME_THICK | LAYOUT_RIGHT)

    if dialog.execute != 0
      # Обновляем данные студента
      student.surname = surname_input.text
      student.name = name_input.text
      student.patronymic = patronymic_input.text
      student.git = git_input.text

      # Обновляем приватные поля через контроллер
      @controller.update_student_field(student, 'email', email_input.text) unless email_input.text.empty?
      @controller.update_student_field(student, 'phone', phone_input.text) unless phone_input.text.empty?
      @controller.update_student_field(student, 'telegram', telegram_input.text) unless telegram_input.text.empty?

      # Обновляем студента в базе данных
      puts "Updating student in DB: #{student.inspect}"  # Debug print
      @controller.update_student_in_db(student)

      # Обновляем список студентов
      @students[selected_row] = student

      # Устанавливаем параметры таблицы перед обновлением данных
      set_table_params(['name', 'git', 'email', 'phone', 'telegram'], @students.size)

      # Обновляем таблицу
      update_table(@current_page)
    end
  end

  def delete_student
    selected_row = @selected_row
    puts "Selected row for deletion: #{selected_row}"  # Debug print
    return if selected_row < 0  # Если строка не выбрана, выходим

    student = @students[selected_row]
    puts "Deleting student: #{student.inspect}"  # Debug print

    # Удаляем студента из базы данных
    @controller.delete_student_from_db(student.id)

    # Удаляем студента из массива студентов
    @students.delete_at(selected_row)
    # Обновляем таблицу
    update_table(@current_page)
  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end