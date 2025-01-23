class DataList
  attr_reader :columns_names

  def initialize(data, columns_names)
    @data = data.sort_by(&:id)  # Предполагаем, что элементы имеют метод `id`
    @columns_names = columns_names
    @selected = []
  end

  def data=(new_data)
    @data = new_data.sort_by(&:id)
  end


  def select(number)
    if number >= 0 && number < @data.size
      @selected << @data[number].id unless @selected.include?(@data[number].id)
    else
      puts "Неверный номер"
    end
  end

  def get_selected
    @selected
  end

  def get_names
    ['ID'] + specific_names
  end


  def get_data
    data_with_indices = @data.each_with_index.map do |item, index|
      [index + 1] + specific_data(item)
    end
    DataTable.new(data_with_indices)
  end

  
  private

  def specific_names
    raise NotImplementedError, "Этот метод должен быть реализован в подклассе"
  end

  def specific_data(item)
    raise NotImplementedError, "Этот метод должен быть реализован в подклассе"
  end

  attr_reader :data
end