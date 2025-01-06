class ArrayProcessor
  attr_reader :array

  def initialize(array)
    @array = array.dup.freeze
  end


  def max
    return nil if @array.empty?
    max_element = @array.first

    @array.each do |element|
      max_element = element if yield(max_element, element) < 0
    end

    max_element
  end

 
end