class DataTable

  def initialize(data)
    @data = data
  end

  def get_element(row, column)
    @data[row][column]
  end


  def row_count
    @data.length
  end


  def column_count
    @data[0].length
  end

 
  end
end