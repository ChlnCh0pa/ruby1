class ArrayProcessor
  attr_reader :array

  def initialize(array)
    @array = array.dup.freeze
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

 
end