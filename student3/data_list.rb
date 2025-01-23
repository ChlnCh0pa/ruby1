class DataList
  def initialize(data)
    @data = data.sort_by(&:id) 
    @selected = []
  end


  def select(number)
    if number >= 0 && number < @data.size
      @selected << @data[number].id unless @selected.include?(@data[number].id)
    else
      puts "Invalid number"
    end
  end


  def get_selected
    @selected
  end


  def get_names
    raise NotImplementedError, "This method should be implemented in a subclass"
  end

  def get_data
    raise NotImplementedError, "This method should be implemented in a subclass"
  end

  private

  attr_reader :data
end