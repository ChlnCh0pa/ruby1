class StudentApp < FXMainWindow
  def initialize(app)
    super(app, "Student Table", width: 800, height: 600)

    # Создание панели для фильтров
    filter_frame = FXVerticalFrame.new(self, opts: LAYOUT_FILL_X | LAYOUT_FILL_Y)
    setup_filter_area(filter_frame)

    # Создание панели для таблицы
    table_frame = FXVerticalFrame.new(self, opts: LAYOUT_FILL_X | LAYOUT_FILL_Y)
    setup_table_area(table_frame)

    # Панель для кнопок
    button_frame = FXHorizontalFrame.new(self, opts: LAYOUT_FILL_X | LAYOUT_SIDE_BOTTOM)
    setup_buttons(button_frame)

    # Пример использования дополнительной кнопки "Сбросить"
    reset_button = FXButton.new(button_frame, "Сбросить", opts: BUTTON_NORMAL)
    reset_button.connect(SEL_COMMAND) do
      reset_filters
      update_buttons_state
    end
  end

  def setup_filter_area(parent)
    FXLabel.new(parent, "Параметры фильтрации: ")

    FXLabel.new(parent, "Фамилия и инициалы:")
    @name_input = FXTextField.new(parent, 25, opts: TEXTFIELD_NORMAL)

    # Добавляем остальные поля ввода фильтров
    FXLabel.new(parent, "Email:")
    @email_input = FXTextField.new(parent, 25, opts: TEXTFIELD_NORMAL)

    FXLabel.new(parent, "Телефон:")
    @phone_number_input = FXTextField.new(parent, 25, opts: TEXTFIELD_NORMAL)

    FXLabel.new(parent, "Telegram:")
    @telegram_input = FXTextField.new(parent, 25, opts: TEXTFIELD_NORMAL)

    FXLabel.new(parent, "Git:")
    @git_input = FXTextField.new(parent, 25, opts: TEXTFIELD_NORMAL)

    # Кнопка для сброса фильтров
    FXButton.new(parent, "Сбросить", opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
      reset_filters
    end
  end

  def setup_table_area(parent)
    @table = FXTable.new(parent, opts: LAYOUT_FILL_X | LAYOUT_FILL_Y)
    @table.setTableSize(0, 5)  # Изначально таблица пуста

    # Настройка колонок
    @table.setColumnText(0, "Фамилия и инициалы")
    @table.setColumnText(1, "Email")
    @table.setColumnText(2, "Телефон")
    @table.setColumnText(3, "Telegram")
    @table.setColumnText(4, "Git")

    # Добавление текстового сообщения "Нет данных"
    @no_data_label = FXLabel.new(parent, "Нет данных для отображения", opts: LAYOUT_CENTER_X | LAYOUT_CENTER_Y)
    @no_data_label.visible = false  # Скрываем по умолчанию

    update_table_data
  end

  def update_table_data
    # Пример данных для таблицы
    data = [
      ["Иванов И.И.", "ivanov@example.com", "+79990000000", "@ivanov", "ivanov_git"],
      ["Петров П.П.", "petrov@example.com", "+79990000001", "@petrov", "petrov_git"]
    ]

    # Очищаем таблицу перед добавлением новых данных
    @table.setTableSize(data.size, 5)

    # Заполняем таблицу данными
    data.each_with_index do |row, row_index|
      row.each_with_index do |value, col_index|
        @table.setItemText(row_index, col_index, value)
      end
    end

    # Если данных нет, показываем сообщение "Нет данных"
    if data.empty?
      @no_data_label.visible = true
    else
      @no_data_label.visible = false
    end

    # Обновление размера окна в зависимости от количества элементов
    adjust_window_size
  end

  def adjust_window_size
    # Проверка на количество строк в таблице, чтобы изменить размер окна
    table_rows = @table.numRows
    new_height = 600 + (table_rows * 20)  # Регулируем высоту окна
    new_height = 800 if new_height < 800  # Минимальная высота окна
    self.height = new_height
  end

  def reset_filters
    # Сброс всех фильтров
    @name_input.text = ""
    @email_input.text = ""
    @phone_number_input.text = ""
    @telegram_input.text = ""
    @git_input.text = ""
    update_table_data
  end

  def setup_buttons(parent)
    # Кнопки для добавления, изменения, удаления и обновления
    add_button = FXButton.new(parent, "Добавить", opts: BUTTON_NORMAL)
    add_button.connect(SEL_COMMAND) do
      add_student
    end

    update_button = FXButton.new(parent, "Обновить", opts: BUTTON_NORMAL)
    update_button.connect(SEL_COMMAND) do
      update_student
    end

    delete_button = FXButton.new(parent, "Удалить", opts: BUTTON_NORMAL)
    delete_button.connect(SEL_COMMAND) do
      delete_student
    end
  end

  def add_student
    # Логика добавления студента
    puts "Добавление студента"
  end

  def update_student
    # Логика обновления студента
    puts "Обновление студента"
  end

  def delete_student
    # Логика удаления студента
    puts "Удаление студента"
  end

  def update_buttons_state
    # Логика активации/деактивации кнопок в зависимости от выделенной строки
    selected_rows = @table.getSelectedRows
    if selected_rows.empty?
      # Только кнопка "Удалить" доступна, если нет выбранных строк
      disable_buttons_except("Удалить")
    elsif selected_rows.size == 1
      # Доступны кнопки "Изменить" и "Удалить", если одна строка выделена
      enable_buttons(["Изменить", "Удалить"])
    else
      # Только кнопка "Удалить" доступна, если выбраны несколько строк
      disable_buttons_except("Удалить")
    end
  end

  def disable_buttons_except(except_button)
    # Логика для отключения кнопок, кроме указанной
    buttons = ["Добавить", "Изменить", "Удалить", "Обновить"]
    buttons.each do |button|
      button = find_button(button)
      button.disable unless button.text == except_button
    end
  end

  def enable_buttons(buttons)
    # Включаем указанные кнопки
    buttons.each do |button|
      find_button(button).enable
    end
  end

  def find_button(button_name)
    # Поиск кнопки по имени (для примера)
    case button_name
    when "Добавить"
      @add_button
    when "Изменить"
      @update_button
    when "Удалить"
      @delete_button
    when "Обновить"
      @update_button
    else
      raise "Неизвестная кнопка"
    end
  end

  def create
    show(PLACEMENT_SCREEN)
  end
end

app = FXApp.new
StudentApp.new(app)
app.create
app.run
