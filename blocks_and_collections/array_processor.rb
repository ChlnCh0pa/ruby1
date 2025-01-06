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

  def max
    return nil if @array.empty?
    max_element = @array.first

    @array.each do |element|
      max_element = element if yield(max_element, element) < 0
    end

    max_element
  end

  def sort
    return to_enum(:sort) unless block_given?
    result = @array.dup

    (result.length - 1).times do
      (0...result.length - 1).each do |i|
        if yield(result[i], result[i + 1]) > 0
          result[i], result[i + 1] = result[i + 1], result[i]
        end
      end
    end

    result
  end

  def map
    return to_enum(:map) unless block_given?
    result = []

    @array.each do |element|
      result << yield(element)
    end

    result
  end

  def detect
    return to_enum(:detect) unless block_given?

    @array.each do |element|
      return element if yield(element)
    end

    nil
  end

  def select
    return enum_for(:select) unless block_given?

    result = []
    @array.each do |element|
      result << element if yield(element)
    end
    result
  end
end