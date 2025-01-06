class ArrayProcessor
  attr_reader :array

  def initialize(array)
    @array = array.dup.freeze
  end

  def drop_while
    return to_enum(:drop_while) unless block_given?
    result = []
    dropping = true

    @array.each do |element|
      if dropping && !yield(element)
        dropping = false
      end
      result << element unless dropping
    end

    result
  end

end