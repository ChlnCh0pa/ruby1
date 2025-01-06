class ArrayProcessor
  attr_reader :array

  def initialize(array)
    @array = array.dup.freeze
  end
  def detect
    return to_enum(:detect) unless block_given?

    @array.each do |element|
      return element if yield(element)
    end

    nil
  end
end