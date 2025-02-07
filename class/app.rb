require 'fox16'
include Fox

class StudentApp < FXMainWindow
  def initialize(app)
    super(app, "Управление Студентами", width: 1080, height: 505)

    @current_page = 1
    @items_per_page = 6
    @total_pages = 1

    @table_data = []
    @table_shown = []

    tab_book = FXTabBook.new(self, opts: LAYOUT_FILL)

    tab1 = FXTabItem.new(tab_book, "Список студентов", nil)
    tab1_frame = FXVerticalFrame.new(tab_book, opts: LAYOUT_FILL)
    setup_main_interface(tab1_frame)

    tab2 = FXTabItem.new(tab_book, "Вкладка 2", nil)
    tab2_frame = FXVerticalFrame.new(tab_book, opts: LAYOUT_FILL)
    FXLabel.new(tab2_frame, "Это содержимое второй вкладки")

    tab3 = FXTabItem.new(tab_book, "Вкладка 3", nil)
    tab3_frame = FXVerticalFrame.new(tab_book, opts: LAYOUT_FILL)
    FXLabel.new(tab3_frame, "Это содержимое третьей вкладки")
  end

  def setup_main_interface(parent)
    main_frame = FXHorizontalFrame.new(parent, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    filter_frame = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 250, padding: 10)
    setup_filter_area(filter_frame)

    table_frame = FXVerticalFrame.new(main_frame, LAYOUT_FILL_X | LAYOUT_FILL_Y, padding: 10)
    setup_table_area(table_frame)

    control_frame = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 150, padding: 10)
    setup_control_area(control_frame)

    refresh_data
  end

  def setup_filter_area(parent)
    FXLabel.new(parent, "Параметры фильтрации: ")

    FXLabel.new(parent, "Фамилия и инициалы:")
    @name_input = FXTextField.new(parent, 25, opts: TEXTFIELD_NORMAL)

    add_filtering_row(parent, "Email:", :email)
    add_filtering_row(parent, "Телефон:", :phone_number)
    add_filtering_row(parent, "Telegram:", :telegram)
    add_filtering_row(parent, "Git:", :git)

    FXButton.new(parent, "Сбросить", opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
      reset_filters
    end
  end

  def add_filtering_row(parent, label, rw)
    FXLabel.new(parent, label)

    button_frame = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
    rb_yes = FXRadioButton.new(button_frame, "Да")
    rb_no = FXRadioButton.new(button_frame, "Нет")
    rb_dk = FXRadioButton.new(button_frame, "Не важно")

    text_field = FXTextField.new(parent, 25, opts: TEXTFIELD_NORMAL)
    text_field.enabled = false

    rb_dk.check = true

    rb_yes.connect(SEL_COMMAND) { handle_radio_button(rb_yes, true, text_field) }
    rb_no.connect(SEL_COMMAND) { handle_radio_button(rb_no, false, text_field) }
    rb_dk.connect(SEL_COMMAND) { handle_radio_button(rb_dk, nil, text_field) }
  end

  def handle_radio_button(selected_button, value, text_field)
    selected_button.check = true
    text_field.enabled = value
    text_field.text = ""
  end

  def setup_table_area(parent)
    @table = FXTable.new(parent, opts: LAYOUT_FILL_X | LAYOUT_FILL_Y | TABLE_READONLY | TABLE_COL_SIZABLE)
    @table.setTableSize(@items_per_page + 1, 4)
    @table.setColumnWidth(0, 30)
    (1...4).each { |col| @table.setColumnWidth(col, 204) }
    @table.rowHeaderWidth = 0
    @table.columnHeaderHeight = 0

    @table.connect(SEL_COMMAND) do |_, _, pos|
      if pos.row == 0
        sort_table_by_column(pos.col)
      end

      if pos.col == 0
        @table.selectRow(pos.row)
      end

      update_buttons_state
    end

    navigation_frame = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
    @prev_button = FXButton.new(navigation_frame, "Предыдущая", opts: BUTTON_NORMAL | LAYOUT_LEFT)
    @prev_button.enabled = false
    @next_button = FXButton.new(navigation_frame, "Следующая", opts: BUTTON_NORMAL | LAYOUT_RIGHT)
    @next_button.enabled = true
    @page_label = FXLabel.new(navigation_frame, "", opts: LAYOUT_CENTER_X)

    @prev_button.connect(SEL_COMMAND) { change_page(-1) }
    @next_button.connect(SEL_COMMAND) { change_page(1) }
  end

  def change_page(offset)
    new_page = @current_page + offset
    if new_page == 1
      @prev_button.enabled = false
    else
      @prev_button.enabled = true
    end
    if new_page == @total_pages
      @next_button.enabled = false
    else
      @next_button.enabled = true
    end

    @current_page = new_page

    @page_label.text = "Страница #{@current_page} / #{@total_pages}"
    refresh_data
  end

  def update_buttons_state
    selected_rows = (0...@table.numRows).select { |row| @table.rowSelected?(row) }
    @delete_button.enabled = !selected_rows.empty?
    @edit_button.enabled = selected_rows.size == 1
  end

  def sort_table_by_column(col_idx = 0)
    # Здесь должна быть логика сортировки
  end

  def setup_control_area(parent)
    FXLabel.new(parent, "Управление", opts: LAYOUT_FILL_X)

    @add_button = FXButton.new(parent, "Добавить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @add_button.connect(SEL_COMMAND) { add_entry }

    @delete_button = FXButton.new(parent, "Удалить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @delete_button.connect(SEL_COMMAND) { delete_entries }

    @edit_button = FXButton.new(parent, "Изменить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @edit_button.connect(SEL_COMMAND) { edit_entry }

    @refresh_button = FXButton.new(parent, "Обновить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @refresh_button.connect(SEL_COMMAND) { apply_filter }

    @table.connect(SEL_CHANGED) { update_buttons_state }

    update_buttons_state
  end

  def refresh_data
 
  end

  def apply_filter

  end

  def reset_filters

  end

  def clear_table
    (1...@table.numRows).each do |row|
      (0...@table.numColumns).each do |col|
        @table.setItemText(row, col, "")
      end
    end
  end

  def add_entry

  end

  def edit_entry
    
  end

  def delete_entries
  
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

# Запуск приложения
if __FILE__ == $0
  FXApp.new do |app|
    StudentApp.new(app)
    app.create
    app.run
  end
end