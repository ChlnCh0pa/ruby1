require 'minitest/autorun'
require_relative 'array_processor'

class ArrayProcessorTest < Minitest::Test
  def setup
    @array = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
    @processor = ArrayProcessor.new(@array)
  end

  def test_initialize
    assert_equal @array, @processor.array
    assert @processor.array.frozen?
  end

  def test_drop_while
    result = @processor.drop_while { |x| x < 5 }
    assert_equal [5, 9, 2, 6, 5, 3, 5], result

    result = @processor.drop_while { |x| x < 10 }
    assert_equal [], result
  end

  def test_max
    assert_equal 9, @processor.max

    result = @processor.max { |a, b| b <=> a }
    assert_equal 1, result
  end

  def test_sort
    result = @processor.sort { |a, b| a <=> b }
    assert_equal [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9], result

    result = @processor.sort { |a, b| b <=> a }
    assert_equal [9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1], result
  end

  def test_map
    result = @processor.map { |x| x * 2 }
    assert_equal [6, 2, 8, 2, 10, 18, 4, 12, 10, 6, 10], result
  end

  def test_detect
    result = @processor.detect { |x| x > 5 }
    assert_equal 9, result

    result = @processor.detect { |x| x > 10 }
    assert_nil result
  end
def test_select
  result = @processor.select { |x| x > 5 }
  assert_equal [9, 6], result
end
end
