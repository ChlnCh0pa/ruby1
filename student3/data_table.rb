class DataTable
  def initialize(data)
    @data = data
  end

  def display_data
    @data.each do |row|
      puts row.join(", ")
    end
  end
end