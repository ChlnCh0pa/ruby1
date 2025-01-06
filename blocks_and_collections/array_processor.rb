class ArrayProcessor
  attr_reader :array

  def initialize(array)
    @array = array.dup.freeze
  end

  def map
    return to_enum(:map) unless block_given?
    result = []
    @array.each do |element|
      result << yield(element)
    end

    result
  end


end