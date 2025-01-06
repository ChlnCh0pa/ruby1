require_relative 'array_processor'

def run_tests
  processor = ArrayProcessor.new([3, 1, 4, 1, 5, 9, 2, 6, 5])

  puts "Testing drop_while"
  p processor.drop_while { |x| x < 5 } == [5, 9, 2, 6, 5]

  puts "Testing max"
  p processor.max { |a, b| a <=> b } == 9

  puts "Testing sort"
  p processor.sort { |a, b| a <=> b } == [1, 1, 2, 3, 4, 5, 5, 6, 9]

  puts "Testing map"
  p processor.map { |x| x * 2 } == [6, 2, 8, 2, 10, 18, 4, 12, 10]

  puts "Testing detect"
  p processor.detect { |x| x > 4 } == 5

  puts "Testing select"
  p processor.select { |x| x.odd? } == [3, 1, 1, 5, 9, 5]
end

run_tests