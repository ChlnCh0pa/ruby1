class ArrayProcessor
  attr_reader :array

  def initialize(array)
    @array = array.dup.freeze
  end
  
def select
    return enum_for(:select) unless block_given?

    result = []
    array.each do |element|
      result << element if yield(element)
    end
    result
  end
end